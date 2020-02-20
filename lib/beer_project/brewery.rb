class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website
  
  def initialize(name, address, website)
	  @name = name
	  @address = address
	  @website = website
		@@all << self
  end
  
  def self.all
    BeerProject::Scraper.scrape_brewery_info if @@all.empty? 
    @@all
  end
  
  
end