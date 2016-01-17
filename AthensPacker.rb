#!/usr/bin/env ruby
require 'fileutils'

# Load the modules
require_relative 'modules/Logging'

# Let's Include Logger's methods
include Logging

# Start the script!
logger.info("Starting AthensPacker...")

def directory_exists?(directory)
  File.directory?(directory)
end

def create_directory(directory)
  FileUtils::mkdir_p("#{directory}") unless directory_exists?("#{directory}")
end

def move_to_mods_folder(filename)
	create_directory("mods")
	FileUtils::cp_r("#{filename}", "mods/")
	logger.debug("Moved #{filename} to mods/")
end

def remove_mods_folder
	FileUtils::rm_rf 'mods/'
	logger.debug("Removed Mods Folder")
end

create_directory("to_package")
create_directory("to_upload")

if directory_exists?("mods") then
	logger.warn("The mods folder already exist... so deleting")
	remove_mods_folder
end

logger.info("Checking if there are mods to package...")
print Dir.glob("to_package/*").sort unless Dir.glob("to_package/*").empty?

if Dir.glob("to_package/*").empty?
	logger.fatal ("There are no mods to package... aborting")
	abort
end

to_package_files = Dir.glob("to_package/*")
@to_package_files_count = to_package_files.count.to_s
to_package_files.each do |mod|
	logger.debug("Found file #{mod}")
	move_to_mods_folder(mod)
	logger.info("zipping file.. #{mod}")
	# Downcase the filename, remove .jar and .zip
	# Then remove spaces and quotes then add .zip so the zipfile can be created & properly named
	zipfile_name = mod.downcase.chomp(".jar").chomp(".zip").tr(" '\"", "") + ".zip"

	system("zip -r '#{zipfile_name}' 'mods/'")
	logger.debug("Moving #{zipfile_name}")
	puts zipfile_name
	FileUtils::mv("#{zipfile_name}", "to_upload/")
	FileUtils::rm("#{to_package}") # Remove other file
	remove_mods_folder
end
to_upload_files = Dir.glob("to_upload/*")

puts @to_package_files_count + " mods were to_package/"
puts to_upload_files.count.to_s + " mods in to_upload/"
