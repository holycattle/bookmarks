#!/usr/bin/env ruby

require 'pathname'
require 'webrick'
include WEBrick

directory = Pathname.new(__FILE__).parent.parent.join('build')

s = HTTPServer.new(:Port => 7777,  :DocumentRoot => directory)
trap("INT"){ s.shutdown }
s.start
