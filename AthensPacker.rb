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

def create_mods_folder
	FileUtils::mkdir_p 'mods/' unless directory_exists?("mods/")
end

def move_to_mods_folder(filename)
	logger.debug("Moving #{filename}")
	create_mods_folder
	FileUtils::cp_r("#{filename}", "mods/")
	logger.debug("Moved #{filename} to mods/")
end

def remove_mods_folder
	FileUtils::rm_rf 'mods/'
	logger.debug("Removed Mods Folder")
end

def remove_file_from_mods(filename)
	File.delete("../mods/#{filename}")
	logger.debug("Deleted #{filename} from mods/")
end

if !directory_exists?("to_package") then 
	logger.fatal("The to_package folder does not exist")
	logger.info("Creating to_package folder then...")
	FileUtils::mkdir_p 'to_package/'
elsif directory_exists?("to_package") then 
	logger.info("The to_package folder exists so skipping creating!") 
end

if !directory_exists?("to_upload") then 
	logger.fatal("The to_upload folder does not exist")
	logger.info("Creating to_upload folder then...")
	FileUtils::mkdir_p 'to_upload/'
elsif directory_exists?("to_upload") then 
	logger.info("The to_upload folder exists so skipping creating!") 
end

if directory_exists?("mods") then 
	logger.warn("The mods folder already exist... so deleting")
	remove_mods_folder
end

logger.info("Checking if there are mods to package...")
print Dir.glob("to_package/*") unless Dir.glob("to_package/*").empty?

if Dir.glob("to_package/*").empty? 
	logger.fatal ("There are no mods to package... aborting")
	abort
end


# This method doens't even work... yet.
def move_zip(filename)
	FileUtils::mv("#{zipfile_name}", "to_upload/")
end

to_package_files = Dir.glob("to_package/*")

to_package_files.each do |to_package|
	logger.debug("Found file #{to_package}")
	move_to_mods_folder(to_package)
	logger.info("zipping file.. #{to_package}")

	zipfile_name = to_package.chomp(".jar") + ".zip"
	
	system("zip -r '#{zipfile_name}' 'mods/'")
	logger.debug("moving #{zipfile_name}")
	puts zipfile_name
	FileUtils::mv("#{zipfile_name}", "to_upload/")

	puts "now removing file.. #{to_package} in mods"
	remove_mods_folder
end
