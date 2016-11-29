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
require_relative '../libs/recipe'
require 'yaml'

metadata = YAML.load_file("/in/spec/metadata.yml")
puts metadata

describe Recipe do
  app = Recipe.new(name: metadata['name'])
  describe "#initialize" do
    it "Sets the application name" do
      expect(app.name).to eq 'xdgurl'
    end
  end

  # describe 'clean_workspace' do
  #   it "Cleans the environment" do
  #     app.clean_workspace
  #     #expect(Dir["/app/*"].empty?).to be(true), "Please clean up from last build"
  #     expect(Dir["/out/*"].empty?).to be(true), "AppImage exists, please remove"
  #   end
  # end

  describe 'install_packages' do
    it 'Installs distribution packages' do
      expect(app.install_packages(packages: metadata['packages'])).to be(0), " Expected 0 exit Status"
    end
  end

  describe 'clone_repo' do
    it 'Clones necessary repos that need to be built from source' do
      projecturl = metadata['url']
      expect(app.clone_repo(repo: projecturl)).to be(0), " Expected 0 exit Status"
    end
  end

  # describe 'get_archives' do
  #   it 'Uses wget to retrieve archives from the interwebz' do
  #     expect(app.get_archives(archives: metadata['archives']['loc'])).to be(0), "Expected 0 status"
  #   end
  # end

  describe 'get_git_version' do
    it 'Retrieves the version number from the git repo' do
      expect(app.get_git_version()).not_to be_nil, "Expected the version not to be nil"
    end
  end

  describe 'build_make' do
    it 'Builds makefile source' do
      expect(app.build_make()).to be(0), " Expected 0 exit Status"
    end
  end

  describe 'gather_integration' do
    it 'Gather and adjust desktop file' do
      expect(app.gather_integration(desktop: 'xdgurl')).to be(0), " Expected 0 exit Status"
      expect(File.exist?("/app/#{app.name}.desktop")).to be(true), "Desktop file does not exist, things will fail"
      expect(File.readlines("/app/#{app.name}.desktop").grep(/Icon/).size > 0).to be(true), "No Icon entry in desktop file will fail this operation."
    end
  end

  describe 'copy_icon' do
    it 'Retrieves a suitable icon for integration' do
      expect(app.copy_icon(icon: 'emblem-web.png', iconpath:  '/usr/share/icons/gnome/48x48/emblems/')).to be(0), " Expected 0 exit Status"
      expect(File.exist?("/app/#{app.icon}")).to be(true), "Icon does not exist, things will fail"
    end
  end

  describe 'run_integration' do
    it 'Runs desktop integration to prepare app wrapper' do
      expect(app.run_integration()).to be(0), " Expected 0 exit Status"
      expect(File.exist?("/app/usr/bin/#{app.name}.wrapper")).to be(true), "Icon does not exist, things will fail"
      expect(File.exist?("/app/AppRun")).to be(true), "AppRun missing, things will fail"
    end
  end

  describe 'copy_dependencies' do
    it 'Copies over system installed dependencies' do
      expect(app.copy_dependencies(dep_path: metadata['dep_path'])).to be(0), " Expected 0 exit Status"
      expect(File.exist?("/#{app.app_dir}/#{app.desktop}.desktop")).to be(true), "Desktop file does not exist, things will fail"
      expect(File.exist?("/#{app.app_dir}/#{app.icon}")).to be(true), "Icon does not exist, things will fail"
    end
  end

  describe 'copy_libs' do
    it 'Copies lib dependencies generated with ldd' do
      expect(app.copy_libs()).to be(0), " Expected 0 exit Status"
    end
  end

  describe 'move_lib' do
    it 'Moves /lib to ./usr/lib where appimage expects them' do
      app.move_lib
      expect(Dir["/#{app.app_dir}/lib/*"].empty?).to be(true), "Files still in lib, move them to usr"
    end
  end

  describe 'delete_blacklisted' do
    it 'Deletes blacklisted libraries' do
      expect(app.delete_blacklisted()).to be(0), " Expected 0 exit Status"
    end
  end

  describe 'generate_appimage' do
     it 'Generate the appimage' do
       expect(app.generate_appimage()).to eq 0
       expect(File.exist?("/out/#{app.name}-1.0.1-1-x86_64.AppImage")).to be(true), "Something went wrong, no AppImage"
       app.clean_workspace
     end
   end
end
