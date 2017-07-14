#!/usr/bin/env ruby
# encoding: utf-8

require 'yaml'
require_relative '../lib/layout.rb'
require_relative '../lib/template.rb'
require 'highline/import'

WD = File.expand_path(File.dirname(__FILE__))
layout = Layout.new(File.join(WD, '..', 'config', 'config.yml'))
@output = File.open(File.join(WD, '..', 'output', 'wordlist'), 'w')

sample = ask('Enter password for pattern generation:   ')
template = Template.new(layout, sample)
template.generate_passwords.each do |password|
  @output.puts(password)
end

@output.close

say('passwords written to output/wordlist')
