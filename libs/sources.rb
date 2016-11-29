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
    system('ls -l')
    unless Dir.exist?("/app/src")
      Dir.mkdir("/app/src")
    end
    Dir.chdir('/app/src/')
  end

  def get_source(name, type, url, branch='master')
    case "#{type}"
    when 'git'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system( "git clone #{url}")
        unless branch == 'master'
          Dir.chdir("/app/src/#{name}")
          system(" git checkout #{branch}")
        end
      end
    when 'xz'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -xvf #{name}*.tar.xz")
      end
    when 'gz'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -zxvf #{name}*.tar.gz")
      end
    when 'bz2'
      Dir.chdir('/app/src/')
      unless Dir.exist?("/app/src/#{name}")
        system("wget #{url}")
        system("tar -jxvf #{name}.tar.bz2")
      end
    when 'mercurial'
      Dir.chdir('/app/src')
      unless Dir.exist?("/app/src/#{name}")
        system("hg clone #{url}")
      end
    when 'none'
      p "No sources configured"
    else
      "You gave me #{type} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end

  def run_build(name, buildsystem, options, autoreconf=false)
    ENV['PATH']='/opt/usr/bin:/app/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    ENV['LD_LIBRARY_PATH']='/opt/usr/lib:/app/usr/lib:/app/usr/lib/x86_64-linux-gnu:/opt/usr/lib/Qt-5.7.0:/usr/lib64:/usr/lib:/lib:/lib64'
    ENV['CPLUS_INCLUDE_PATH']='/app/usr/include:/opt/usr/include:/usr/include'
    ENV['CFLAGS']="-g -O2 -fPIC"
    ENV['PKG_CONFIG_PATH']='/app/usr/lib/x86_64-linux-gnu/pkgconfig:/app/usr/lib/pkgconfig:/app/usr/share/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig'
    ENV['ACLOCAL_PATH']='/app/usr/share/aclocal:/usr/share/aclocal'
    ENV.fetch('PATH')
    ENV.fetch('LD_LIBRARY_PATH')
    ENV.fetch('CFLAGS')
    ENV.fetch('PKG_CONFIG_PATH')
    ENV.fetch('ACLOCAL_PATH')
    ENV.fetch('CPLUS_INCLUDE_PATH')
    system( "echo $PATH" )
    `echo LD_LIBRARY_PATH`
    `echo CFLAGS`
    `echo PKG_CONFIG_PATH`
    `echo ACLOCAL_PATH`
    `echo CPLUS_INCLUDE_PATH`
    case "#{buildsystem}"
    when 'make'
      Dir.chdir("/app/src/#{name}") do
        unless "#{autoreconf}" == true
          cmd = "mkdir #{name}-build && cd #{name}-build && ../configure prefix=/app/usr #{options} && make -j 8 && make install"
          p "Running " + cmd
          system(cmd)
        end
        if "#{autoreconf}" == true
          p "Running " + cmd
          cmd = "autoreconf --force --install && mkdir #{name}-build && cd #{name}-build && ../configure --prefix=/app/usr #{options} &&  make -j 8 && make install prefix=/app/usr"
          system(cmd)
        end
      end
    when 'cmake'
      Dir.chdir("/app/src/#{name}") do
        p "running cmake #{options}"
        system("mkdir #{name}-build  && cd #{name}-build  && cmake #{options} ../ && make -j 8 && make install")
      end
    when 'custom'
      unless "#{name}" == 'cpan'
        Dir.chdir("/app/src/#{name}") do
          p "running #{options}"
          system("#{options}")
        end
      end
      if "#{name}" == 'cpan'
        p "running #{options}"
        system("#{options}")
      end
    when 'qmake'
      Dir.chdir("/app/src/#{name}") do
        p "running qmake #{options}"
        system('echo $PATH')
        system("#{options}")
        system('make -j 8 && make install')
      end
    when 'bootstrap'
      Dir.chdir("/app/src/#{name}") do
        p "running ./bootstrap #{options}"
        system("./bootstrap #{options}")
        system('make -j 8 && make install')
      end
    else
    "You gave me #{buildsystem} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end
end
