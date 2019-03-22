#!/usr/bin/env ruby

require 'miga'
q = true
proj_path = ARGV.shift

p = MiGA::Project.load(proj_path) or raise "Invalid project: #{proj_path}"

tt = []
p.each_dataset do |d|
  t = 0.0
  n += 1
  d.each_result do |r_sym, r|
    if r.running_time.nil?
      $stderr.puts "Faulty result: #{p.name}:#{d.name}:#{r_sym}"
    else
      t += r.running_time
    end
  end
  tt << t
end
puts tt.inject(:+)/tt.size

