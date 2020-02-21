class BeerProject::CLI
  
  def start
  puts "What city are you in?"
  cities
  #puts "Lets find a brewery"
  #breweries
  end
  
  def breweries
    BeerProject::Brewery.all.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address
      puts brewery.website
    end
  end
  
  def cities
  BeerProject::City.all.each.with_index(1) do |city, index|
      puts "#{index}. #{city.name}"
    end
  end
  
end