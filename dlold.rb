#!/bin/ruby

require 'open-uri'
class RubyBinary
  # https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz
  #attr_reader :version 
  #def initialize(v)
  #  @version = v
  #end
  version = ARGV[0]
  location = ARGV[1]
  def download(location)
    major = version.split(".")[0]
    minor = version.split(".")[1]
    url = "https://cache.ruby-lang.org/pub/ruby/" + major + "." + minor + "/ruby-" + version + ".tar.gz"
	f = "/" + location + "/" + 'ruby' + version + ".tar.gz"
    puts url 
    puts f
	File.open(f, "wb") do |file|
		file.write open(url).read
    end
  end
end


#ruby_bin = RubyBinary.new("2.3.0")
#ruby_bin.download("tmp")
