#!/usr/bin/env ruby

require 'miga'
q = true
proj_path = ARGV.shift

p = MiGA::Project.load(proj_path) or raise "Invalid project: #{proj_path}"

class MiGA::Project
  def each_result(&blk)
    @@RESULT_DIRS.keys.each do |k|
      blk.call(k, result(k)) unless result(k).nil?
    end
  end
end

t = 0.0
p.each_result do |r_sym, r|
  #puts "#{r_sym}\t#{r.running_time}"
  if r.running_time.nil?
    $stderr.puts "Faulty result: #{p.name}:#{r_sym}"
    puts "NA"
    exit
  end
  t += r.running_time
end
puts t

