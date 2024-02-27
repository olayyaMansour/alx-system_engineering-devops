#!/usr/bin/env ruby

# Accepts one argument (log entry) and extracts sender, receiver, and flags information
def extract_info(log_entry)
  sender = log_entry.scan(/\[from:([^\]]+)\]/).flatten.first
  receiver = log_entry.scan(/\[to:([^\]]+)\]/).flatten.first
  flags = log_entry.scan(/\[flags:([^\]]+)\]/).flatten.first

  "#{sender},#{receiver},#{flags}"
end

# Read the log file line by line and process each entry
if ARGV.length != 1
  puts "Usage: #{$PROGRAM_NAME} 'log_entry'"
else
  log_entry = ARGV[0]
  puts extract_info(log_entry)
end
