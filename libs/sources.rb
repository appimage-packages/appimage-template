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
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.  If not, see <http://www.gnu.org/licenses/>.
require 'yaml'




class Sources
  attr_accessor :name

  def initialize()
    Dir.chdir('/')
    unless Dir.exist?("/app/src")
      Dir.mkdir("/app/src")
    end
    Dir.chdir('/app/src/')
  end

  def get_sources()
    metadata = YAML.load_file("/in/spec/metadata.yml")
    deps = metadata['dependencies']
    deps.each do |dep|
      name =  dep.values[0]['depname']
      p name
      system('ls -l')
      type = dep.values[0]['source'].values_at('type').to_s.gsub(/\,|\[|\]|\"/, '')
      url = dep.values[0]['source'].values_at('url').to_s.gsub(/\,|\[|\]|\"/, '')
      buildsystem = dep.values[0]['build'].values_at('buildsystem').to_s.gsub(/\,|\[|\]|\"/, '')
      options = dep.values[0]['build'].values_at('buildoptions').to_s.gsub(/\,|\[|\]|\"/, '')
      run_case(name, type, url)
      run_build(name, buildsystem, options)
    end
    name = metadata['name']
    type = metadata['type']
    url = metadata['url']
    buildsystem = metadata['buildsystem']
    options = metadata['buildoptions']
    run_case(name, type, url)
    run_build(name, buildsystem, options)
    $?.exitstatus
  end

  def run_case(name, type, url)
    case "#{type}"
    when 'git'
      Dir.chdir('/app/src/')
      system( "git clone #{url}")
    when 'tar'
      Dir.chdir('/app/src/')
      system('ls')
      system("wget #{url}")
      system("tar -xvf #{name}")
    when 'bz2'
      Dir.chdir('/app/src/')
      system('ls')
      system("wget #{url}")
      system("tar -jxvf #{name}")
    else
      "You gave me #{type} -- I have no idea what to do with that."
    end
  end

  def run_build(name, buildsystem, options)
    case "#{buildsystem}"
    when 'make'
      Dir.chdir("/app/src/#{name}") do
        system('ls')
        system("./configure --prefix=/app/usr #{options}")
        system('make -j 8 && sudo make install prefix=/app/usr')
      end
    when 'cmake'
      Dir.chdir("/app/src/#{name}") do
        system('ls')
        system("cmake -DCMAKE_INSTALL_PREFIX:PATH=/app/usr #{options}")
        system('make -j 8 && sudo make install')
      end
    when 'custom'
      Dir.chdir("/app/src/#{name}") do
        system('ls')
        system("#{options}")
      end
    when 'qmake'
      Dir.chdir("/app/src/#{name}") do
        system('ls')
        system("qmake #{options}")
      end
    when 'bootstrap'
      Dir.chdir("/app/src/#{name}") do
        system('ls')
        system("./bootstrap #{options}")
        system('make -j 8 && sudo make install')
      end
    else
    "You gave me #{buildsystem} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end
end
