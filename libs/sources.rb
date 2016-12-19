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
    when 'bzr'
      Dir.chdir('/app/src')
      unless Dir.exist?("/app/src/#{name}")
        system("bzr branch #{url}")
      end
    when 'none'
      p "No sources configured"
    else
      "You gave me #{type} -- I have no idea what to do with that."
    end
    $?.exitstatus
  end

  def run_build(name, buildsystem, options, path, autoreconf=false, insource=false)
    ENV['PATH']='/opt/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    ENV['LD_LIBRARY_PATH']='/opt/usr/lib:/opt/usr/lib/x86_64-linux-gnu:/usr/lib:/usr/lib/x86_64-linux-gnu:/usr/lib64:/usr/lib:/lib:/lib64'
    ENV['CPLUS_INCLUDE_PATH']='/opt/usr:/opt/usr/include:/usr/include'
    ENV['CFLAGS']="-g -O2 -fPIC"
    ENV['PKG_CONFIG_PATH']='/opt/usr/lib/pkgconfig:/opt/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig'
    ENV['ACLOCAL_PATH']='/opt/usr/share/aclocal:/usr/share/aclocal'
    ENV.fetch('PATH')
    ENV.fetch('LD_LIBRARY_PATH')
    ENV.fetch('CFLAGS')
    ENV.fetch('PKG_CONFIG_PATH')
    ENV.fetch('ACLOCAL_PATH')
    ENV.fetch('CPLUS_INCLUDE_PATH')
    system( "echo $PATH" )
    system( "echo $LD_LIBRARY_PATH" )
    system( "echo $CFLAGS" )
    system( "echo $PKG_CONFIG_PATH" )
    system( "echo $ACLOCAL_PATH" )
    system( "echo $CPLUS_INCLUDE_PATH" ) 
    case "#{buildsystem}"
    when 'make'
      Dir.chdir("#{path}") do
        unless "#{autoreconf}" == true
          unless "#{insource}" == true
            cmd = "mkdir #{name}-builddir && cd #{name}-builddir && ../configure --prefix=/opt/usr #{options} && make -j 8 && make install"
          end
          if "#{insource}" == true
            cmd = "cd #{name} && ../configure --prefix=/opt/usr #{options} && make -j 8 && make install"
          end
          p "Running " + cmd
          system(cmd)
          system("rm -rfv  #{name}-builddir")
        end
        if "#{autoreconf}" == true
          p "Running " + cmd
          unless "#{insource}" == true
            cmd = "autoreconf --force --install && mkdir #{name}-builddir && cd #{name}-builddir && ../configure --prefix=/opt/usr #{options} &&  make -j 8 && make install prefix=/opt/usr"
          end
          if "#{insource}" == true
            cmd = "autoreconf --force --install && cd #{name} && ../configure --prefix=/opt/usr #{options} &&  make -j 8 && make install prefix=/opt/usr"
          end
          system(cmd)
          system("rm -rfv  #{name}-builddir")
        end
      end
    when 'cmake'
      Dir.chdir(path) do
        p "running cmake #{options}"
        system("mkdir #{name}-builddir  && cd #{name}-builddir  && cmake #{options} ../ && make -j 8 && make install")
        system("rm -rfv  #{name}-builddir")
        $?.exitstatus
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
      Dir.chdir("#{path}") do
        p "running qmake #{options}"
        system('echo $PATH')
        system("#{options}")
        system('make -j 8 && make install')
      end
    when 'bootstrap'
      Dir.chdir(path) do
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
