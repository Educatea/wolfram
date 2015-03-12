require 'ostruct'
require 'open-uri'
require 'active_support/core_ext/hash'
require "wolfram/version"

module Wolfram
	def self.ask(query)
		response = OpenStruct.new
		hash = Hash.new
		url = "http://api.wolframalpha.com/v2/query?appid=XR5V85-RTLWAEKWEQ&input=#{URI::encode(query).gsub('=','%3D').gsub('+','%2B').gsub(',','%2C')}&format=image"
		raw_response = Hash.from_xml(open(url).read)
		raw_response["queryresult"]["pod"].each do |pod|
			hash[pod["title"].downcase.tr(' ', '_')] = pod["subpod"]["img"]["src"]
		end
		response = OpenStruct.new(hash)
	end
end
