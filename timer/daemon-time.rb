#!/usr/bin/env ruby

require 'time'
q = true
proj_path = ARGV.shift
daemon_dir = File.expand_path('daemon', proj_path)
daemon_path = File.expand_path("MiGA:#{File.basename proj_path}.output", daemon_dir)

added_time = 0
first_time = nil
last_time = nil
first_dashes = true

$stderr.puts "Daemon log path: #{daemon_path}." unless q

File.open(daemon_path, 'r') do |fh|
  fh.each do |ln|
    next unless m = /^\[([^\]]+)\] (-{7})?/.match(ln)
    if m[2]
      if first_dashes
	first_dashes = false
        unless first_time.nil?
	  added_time += Time.parse(last_time) - first_time
	  $stderr.puts "Daemon off: #{Time.parse last_time}" unless q
        end
        first_time = Time.parse(m[1])
	$stderr.puts "Daemon on:  #{first_time}" unless q
      else
        first_dashes = true
      end
    end
    last_time = m[1]
    break if ln =~ /Spawned .* for \S+:subclades:miga-project/
  end
end

unless first_time.nil?
  added_time += Time.parse(last_time) - first_time
  $stderr.puts "Daemon off: #{Time.parse last_time}" unless q
end

puts added_time / 60

