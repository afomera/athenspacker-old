# Require Gem Logger
require 'logger'

module Logging
	def logger
		# Control the level of logging output to console / file
		# If silent is true, the log will NOT output Debug Messages
		# change silent to false to output debug level messages
		slient = false
		if slient == false
			Logging.logger.level = Logger::DEBUG
		else
			Logging.logger.level = Logger::INFO
		end

		# Format Logger Output to: [DEBUG] 04-30 22:58:36: MSG
		Logging.logger.formatter = proc do |severity, datetime, progname, msg|
		   "[#{severity}] #{datetime.strftime('%m-%d %H:%M:%S')}: #{msg}\n"
		end
		Logging.logger
	end

	def self.logger
		@logger ||= Logger.new(STDERR)
	end
end
