#!/usr/bin/ruby

require "pp"

class Wendenal

  items = []

  File.open("#{ARGV}").each_line do |line|
    items << line.scan(/(\d+) (\w+ ?\w*) at (\d{1,2}.\d{2})/).flatten
  end

  pp items

end
