class BeerProject::City
  attr_accessor :name
  
  def intitalize(name)
    @name = name
  end
  
  @@all = []
  
  def self.all
    @@all
  end
  
  
end