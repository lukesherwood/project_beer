class BeerProject::CLI
  
  def start
  puts "Welcome to Find a Brewery CLI app"
  cities
  get_user_city
  breweries
  get_user_brewery
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
    @breweries = BeerProject::Brewery.all
    @breweries.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address
    end
  end
  
  def get_user_brewery
    chosen_brewery_number = gets.strip.to_i-1
    show_brewery_info(chosen_brewery_number) if valid_input?(chosen_brewery_number, @breweries)
    #need to raise an error if valid_input? is false
  end
  
  def get_user_city
    chosen_city_number = gets.strip.to_i-1
    show_breweries_for(chosen_city_number) if valid_input?(chosen_city_number, @cities)
    #need to raise an error if valid_input? is false and return to top, ?while valid input false repeat?
  end
  
  def valid_input?(input, data)
    input.to_i <= data.length && input.to_i >= 0
  end
  
  def show_breweries_for(city_number)
    puts "\nShowing breweries in \n#{@cities[city_number].name}"
    BeerProject::Scraper.site = @cities[city_number].website
  end
  
  def show_brewery_info(brewery_number)
    puts "\nShowing informaton for:\n#{@breweries[brewery_number].name}"
    puts @breweries[brewery_number].blurb
    puts "\nPhone:#{@breweries[brewery_number].phone_number}"
    puts "Find more information at their website: #{@breweries[brewery_number].website}"
  end
end