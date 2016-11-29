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
require 'erb'
require 'fileutils'
require 'yaml'

class Recipe
  attr_accessor :name
  attr_accessor :arch
  attr_accessor :desktop
  attr_accessor :icon
  attr_accessor :iconpath
  attr_accessor :install_path
  attr_accessor :packages
  attr_accessor :dep_path
  attr_accessor :repo
  attr_accessor :type
  attr_accessor :archives
  attr_accessor :md5sum
  attr_accessor :version
  attr_accessor :app_dir
  attr_accessor :configure_options
  ENV['PATH']='/app/usr/bin:/opt/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  ENV['LD_LIBRARY_PATH']='/app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/opt/usr/lib/Qt-5.7.0:/usr/lib64:/usr/lib'

  def initialize(args = {})
    Dir.chdir('/')
    self.name = args[:name]
    self.arch = `arch`
    self.install_path = '/app/usr'
  end

  def clean_workspace(args = {})
    return if Dir['/app/'].empty?
    FileUtils.rm_rf("/app/.", secure: true)
    return if Dir['/appimage/'].empty?
    FileUtils.rm_rf("/appimage/.", secure: true)
  end

  def install_packages(args = {})
    self.packages = args[:packages].to_s.gsub(/\,|\[|\]/, '')
    # system('sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test')
    # system('sudo apt-get update')
    # system('sudo apt-get -y install  gcc-6 g++-6')
    # system('sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6')
    system('apt-get update && sudo apt-get -y upgrade')
    system("apt-get -y install git wget #{packages}")
    $?.exitstatus
  end

  def set_version(args = {})
    self.type = args[:type]
    p "#{type}"
    Dir.chdir("/app/src/#{name}") do
      if  "#{type}" == 'git'
        self.version = `git describe`.chomp.gsub("release-", "").gsub(/-g.*/, "")
        p "#{version}"
      else
        self.version = '1.0'
      end
    end
  end

  def render
    ERB.new(File.read('/in/libs/Recipe.erb')).result(binding)
  end

  def generate_appimage(args = {})
    Dir.chdir("/") do
      system('/bin/bash -xe /in/Recipe')
    end
    $?.exitstatus
  end


end
