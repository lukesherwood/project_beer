class BeerProject::CLI
  
  def start
  puts "Welcome to Find a Brewery CLI app"
  cities
  get_user_city
  breweries
  end
  
  def cities
    #need to add other pages of search
    puts "What city are you in?"
    @cities = BeerProject::City.all
    puts "Choose your city by entering the number"
    @cities.each.with_index(1) do |city, index|
      puts "#{index}. #{city.name}\n"
    end
  end
  
  def breweries
    puts "\nEnter the number of the brewery you want to know more about"
    BeerProject::Brewery.all.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address
      puts brewery.website
    end
  end
  
  
  
  def get_user_city
    chosen_city_number = gets.strip.to_i-1
    show_breweries_for(chosen_city_number) if valid_input?(chosen_city_number, @cities)
    #need to raise an error if valid_input? is false
  end
  
  def valid_input?(input, data)
    input.to_i <= data.length && input.to_i >= 0
  end
  
  def show_breweries_for(chosen_city_number)
    puts "Showing breweries in #{@cities[chosen_city_number].name}"
    ##not working
    #binding.pry
    BeerProject::Scraper.site = @cities[chosen_city_number].website
    
  end
  
end