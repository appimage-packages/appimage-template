#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Copyright (C) 2016 Scarlett Clark <sgclark@kde.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) version 3, or any
# later version accepted by the membership of KDE e.V. (or its
# successor approved by the membership of KDE e.V.), which shall
# act as a proxy defined in Section 6 of version 3 of the license.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License fo-r more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
require 'fileutils'
require 'yaml'
require 'fileutils'
require 'yaml'
require 'set'

@name = 'artikulate'
@url = 'http://anongit.kde.org/' + @name
@base_dir = Dir.pwd + '/'
@kf5 = []
KF5 = YAML.load_file(File.join(__dir__, 'kf5.yaml'))

def clone_project
  system('git clone ' + @url)
end

def install_packages
  # Get deps
  system("export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y build-dep #{@name}")
end

def run_cmakedependencies
  all = []
  all_deps = []
  # Run the cmake-dependencies.py tool from kde-dev-tools
  FileUtils.cp('/in/cmake-dependencies.py', @base_dir + @name)
  Dir.chdir(@base_dir + @name) do
    `cmake -DCMAKE_INSTALL_PREFIX:PATH=/app/usr/ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=FALSE`
    system('pwd')
    system('ls -l')
    system("make -j8")
    all = `python3 /in/cmake-dependencies.py | grep '\"project\": '`.sub('\\', '').split(',')

    all.each do |dep|
      parts = dep.sub('{', '').sub('}', '').split(',')
      parts.each do |project|
        a = project.split.each_slice(3).map{ |x| x.join(' ')}.to_s
        if a.to_s.include? "project"
          name = a.gsub((/[^0-9a-z ]/i), '').downcase
          name.slice! "project "
          all_deps.push name
        end
      end
    end
  end
  all_deps
end

def sub_chars(all_deps)
  kf5_base = []
  oddballs = %w(ksolid,kthreadweaver,ksonnet,kattica,kplasma)
  all_deps.each do |dep|
    dep = 'extra-cmake-modules' if dep == 'ecm'
    dep = 'phonon' if dep == 'phonon4qt5experimental' || dep == 'phonon4qt5'
    if dep =~ /kf5/
      dep = dep.sub('kf5', 'k')
    end
    if dep =~ /qt5/
      next
    end
    dep = dep.sub('knewstuffcore', 'knewstuff')
    dep = dep.sub('kk', 'k') if dep =~ /kk/
    dep = dep.sub('k', '') if oddballs.include? dep
    kf5_base.push dep
  end
  kf5_base
end

def extract_kf5
  kf5_base = []
  others = []
  all_deps = run_cmakedependencies
  kf5_base = sub_chars(all_deps)
  kf5_base.each do |f|
    p f
    if f =~ /qt5/
      kf5_base.delete(f)
    end
    kf5_base.delete 'k'
    kf5_base.delete 'kf5'
    kf5_base.delete 'packagehandlestandardargs'
    kf5_base.delete 'packagemessage'
    kf5 = KF5[f]
    p kf5
    if kf5.nil?
      kf5_base.delete(f)
      others.push f
    end
  end
  p others
  p kf5_base
  kf5_base
end

def extract_others
  kf5_base = []
  others = []
  all_deps = run_cmakedependencies
  kf5_base = sub_chars(all_deps)
  kf5_base.each do |f|
    kf5 = KF5[f]
    if kf5.nil?
      kf5_base.delete(f)
      others.push f
    end
  end
  p others
  others
end

def self.generatekf5_buildorder(frameworks)
  buildorder = Set.new

  # get list of frameworks required in CMakeLists.txt
  list = get_kf5deps(frameworks)
  # Take that list and repeat for deps of those.
  deps_ofdeps = get_kf5deps(list)
  # Merge deps of deps into buildorder set.
  buildorder.merge(deps_ofdeps) if deps_ofdeps
  # Merge list and their deps into buildorder set if it is not nil.
  buildorder.merge(list) if list
  # return buildorder.
  buildorder
end

def self.get_kf5deps(frameworks)
  list = Set.new
  frameworks.each do |f|
    current = KF5[f]
    deps = current['kf5_deps']
    list.merge(deps) if deps
    list.delete(f) if deps
    list.add(f) if deps
  end
  list
end

clone_project
install_packages
@kf5 = extract_kf5
orderedkf5 = generatekf5_buildorder(@kf5)
others = extract_others
system('rm -rfv ' + @name)
File.open('/in/generated_deps.yaml', 'w') { |f| f.write orderedkf5.to_yaml }
p orderedkf5.to_yaml
p others
