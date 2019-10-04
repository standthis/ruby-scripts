#!/bin/ruby
require 'open-uri'

class RubyBinary
  def download(location, version)
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

  meth = ARGV[0]
  puts meth
  version = ARGV[1]
  location = ARGV[2]

  if meth == "download"
    download(location, version)
    puts 'success downloaded'
  end
end

#ruby_bin = RubyBinary.new("2.3.0")
#ruby_bin.download("tmp")
