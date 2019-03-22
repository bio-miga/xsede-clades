#!/usr/bin/env ruby

require 'miga'
q = true
proj_path = ARGV.shift

p = MiGA::Project.load(proj_path) or raise "Invalid project: #{proj_path}"

puts "species\tgenome\ttime\tdistances"
p.each_dataset do |d|
  if d.result(:stats)
    r_start = Time.parse d.result(:cds)[:created]
    r_done  = d.result(:stats).done_at
    t = r_done - r_start
    t2 = d.result(:distances).running_time
    puts "#{d.metadata[:db_project]}\t#{d.name}\t#{t}\t#{t2 || 'NA'}"
  else
    $stderr.puts "Incomplete dataset: #{d.name}"
  end
end

