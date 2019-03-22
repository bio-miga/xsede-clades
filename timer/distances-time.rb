#!/usr/bin/env ruby

require 'miga'
q = true
proj_path = ARGV.shift

p = MiGA::Project.load(proj_path) or raise "Invalid project: #{proj_path}"

t = []
p.each_dataset do |d|
  r = d.result(:distances)
  if t.nil? or r.running_time.nil?
    $stderr.puts "Faulty result: #{p.name}:#{d.name}:distances"
  else
    t << r.running_time
  end
end
if t.empty?
  puts 'NA'
else
  puts t.inject(:+)/t.size
end

