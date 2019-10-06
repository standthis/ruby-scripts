#!/bin/ruby
require 'open-uri'
# Target webpage
# https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz
class RubyBinary

  def initialize(version)
    @version = version
  end

  def download(location)
    major, minor = splitVersion(version)
    url = makeURL(major, minor, version)
    saveFile(location, version, url)
  end

  private
  attr_reader :version 

  def splitVersion(version)
    versioning = version.split('.')
    if versioning.count != 3
        puts "#{version} is invalid. Expected $.$.$"
        exit 1
    end
    major, minor = versioning[0], versioning[1]
    return major, minor
  end

  def makeURL(major, minor, version)
    "https://cache.ruby-lang.org/pub/ruby/#{major}.#{minor}/ruby-#{version}.tar.gz"
  end

  def saveFile(location, version, url)
    saveTo = "/#{location}/ruby-#{version}.tar.gz"
    puts "Target save location: #{saveTo}"
    puts "Downloading from #{url}..."
    File.open(saveTo, "wb") do |file| 
      file.write open(url).read
    end
  end
end

def argparse
  if ARGV.length != 3
    puts "#{program_name} method version directory"
    exit 1
  end
  method, version, location = ARGV[0], ARGV[1], ARGV[2]
end

method, version, location = argparse

ruby_bin = RubyBinary.new(version)

if ruby_bin.public_methods(false).include?(method.to_sym)
  ruby_bin.download("tmp")
  puts 'success downloaded'
else
  puts "Method #{method} is not an existing public method of the RubyBinary class"
end
