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

class Sources
  attr_accessor :type
  attr_accessor :url
  attr_accessor :name

  def initialize()
    Dir.chdir('/')
    if Dir.exist?("/app/src") == false
      Dir.mkdir("/app/src")
    end
    Dir.chdir('/app/src/')
  end

  def get_sources(args = {})
    self.type = args[:type]
    self.url = args[:url]
    self.name = args[:name]
    system('pwd')
    case "#{type}"
    when 'git'
      system( "git clone #{url} #{name}")
    when 'tar'
      system("wget #{url}")
      system("tar -xvf #{name}")
    when 'bz2'
      system("wget #{url}")
      system("tar -jxvf #{name}")
    else
    "You gave me #{type} -- I have no idea what to do with that."
     $?.exitstatus
   end
 end
 end
