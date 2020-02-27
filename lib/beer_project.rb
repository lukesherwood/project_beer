require_relative "./beer_project/version"
require_relative "./beer_project/CLI"
require_relative "./beer_project/Scraper"
require_relative "./beer_project/brewery"
require_relative "./beer_project/city"

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'launchy'

module BeerProject
  class Error < StandardError; end
  # Your code goes here...
end