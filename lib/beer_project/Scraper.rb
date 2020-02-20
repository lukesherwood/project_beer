require 'nokogiri'
require 'rubygems'
class BeerProject::Scraper
  #attr_accessor :site
  
  def initialize(site)
    @site = site
  end

#site = "https://www.tripsavvy.com/best-breweries-in-cleveland-4688970"

doc = Nokogiri::HTML(open(@site))


things = doc.css(".comp.list-sc-item.mntl-block")


things.each do |thing|
name = thing.css(".mntl-sc-block-heading__text").text
   website = thing.css(".mntl-sc-block-location__website-text").attr("href")
  address = thing.css(".mntl-sc-block-location__address").text.strip
  
   puts name, website, address
 end
 
 end