#!/usr/bin/ruby

require 'find'
require 'zlib' 
require 'rubygems'
require 'readline'
 
files_crc = {}
 
Find.find(ARGV[0]) do |n|
   
   begin
   fi = File.open(n, "r") 
   data = fi.read
   fi.close
   puts "Calculate crc32 for #{n}"
   crc32 = Zlib::crc32(data)

   files_crc[crc32] = [] unless files_crc.has_key? crc32
   
   files_crc[crc32].push n
   

   rescue Errno::EISDIR => e
   end
   
   
   #puts f if f.match(/\.mp3\Z/)
end

puts "================================================================================================="
puts "====================================Crc Calculation END=========================================="
puts "================================================================================================="

files_crc.each do |crc, files|
  if files.size > 1
    puts files.inspect
    
    line = Readline.readline("Do you want to remove duplicates? y/n ", false)
    
    if line == 'y'
      to_delete = files[1..-1]
      to_delete.each do |path|
        puts "Deleting file #{path}"
        File.delete(path)
      end
    end
  end
end  
