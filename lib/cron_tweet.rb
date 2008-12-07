#!/usr/bin/env ruby -w

env = 'production'

require 'rubygems'
Gem.clear_paths
Gem.path.unshift(File.join(File.dirname(__FILE__), "gems"))

require 'merb-core'
Merb.load_dependencies(:environment => env)

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => env)

Tip.tweet
