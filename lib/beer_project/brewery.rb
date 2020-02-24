class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website, :blurb, :phone_number
  
  def initialize(name, address, website, blurb, phone_number)
	  @name = name
	  @address = address
	  @website = website
	  @blurb = blurb
	  @phone_number = phone_number
		@@all << self
  end
  
  def self.all
    BeerProject::Scraper.scrape_brewery_info if @@all.empty? 
    @@all
  end
  
  
end