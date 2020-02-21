class BeerProject::City
  attr_accessor :name
  
  def intitalize(name, website)
    @name = name
    @webstie = website
    @@all << self
  end
  
  @@all = []
  
  def self.all
    @@all
  end
  
  
end