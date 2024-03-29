#!/bin/ruby
require 'open-uri'
# Target webpage
# https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.5.tar.gz
class RubyBinary

  def initialize(version)
    @version = version
  end

  def download(location)
    url = makeURL
    saveFile(location, url)
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

  def makeURL
    major, minor = splitVersion(version)
    "https://cache.ruby-lang.org/pub/ruby/#{major}.#{minor}/ruby-#{version}.tar.gz"
  end

  def makeDirectory(location)
    "/#{location}/ruby-#{version}.tar.gz"
  end

  def saveFile(location, url)
    saveTo = makeDirectory(location)
    puts "Target save location: #{saveTo}"
    puts "Downloading from #{url}..."
    File.open(saveTo, "wb") do |file| 
      file.write open(url).read
    end
  end
end

class CommandLine
  def self.runcli 
    method, version, location = argparse

    ruby_bin = RubyBinary.new(version)

    if ruby_bin.public_methods(false).include?(method.to_sym)
      ruby_bin.download(location)
      puts 'Success file downloaded'
    else
      puts "Method #{method} is not an existing public method of the RubyBinary class"
    end
  end

  private
  def self.argparse
    if ARGV.length != 3
      puts "./#{File.basename($0)} method version directory"
      exit 1
    end
    method, version, location = ARGV[0], ARGV[1], ARGV[2]
  end
end

CommandLine.runcli
