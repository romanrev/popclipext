#!/usr/bin/env ruby

require "gist"

options = {}
options[:access_token] = ENV['POPCLIP_OPTION_TOKEN']

if ENV['POPCLIP_OPTION_SECRET'] and ENV['POPCLIP_OPTION_SECRET'] == "1"
    options[:private] = true
end

if ENV['POPCLIP_OPTION_OPEN'] and ENV['POPCLIP_OPTION_OPEN'] == "1"
    options[:open] = true
end

if ENV['POPCLIP_OPTION_PROXY']
    ENV['HTTP_PROXY'] = ENV['POPCLIP_OPTION_PROXY']
    ENV['https_proxy'] = ENV['POPCLIP_OPTION_PROXY']
    ENV['HTTP_PROXY'] = ENV['POPCLIP_OPTION_PROXY']
    ENV['HTTPS_PROXY'] = ENV['POPCLIP_OPTION_PROXY']
end

options[:description] = ENV['POPCLIP_OPTION_DESCRIPTION']
options[:filename] = "send2gist.#{ENV['POPCLIP_OPTION_EXTENSION']}"

begin
  puts Gist.gist(ENV['POPCLIP_TEXT'], options)['url']
rescue Gist::Error => e
  puts "Error: #{e.message}"
  exit 1
rescue Interrupt
  # bye!
end
