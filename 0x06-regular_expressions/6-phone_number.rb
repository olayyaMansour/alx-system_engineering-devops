#!/usr/bin/env ruby

# Accepts one argument and passes it to a regular expression matching method
puts ARGV[0].scan(/^\d{10}$/).join
