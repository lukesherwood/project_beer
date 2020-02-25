class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website, :blurb, :phone_number
  
  def initialize(name, address)
	  @name = name
	  @address = address
		@@all << self
  end
  
  def self.all
    BeerProject::Scraper.scrape_brewery_info if @@all.empty? 
    @@all
  end
  
  
end