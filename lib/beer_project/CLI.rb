class BeerProject::CLI
  @input = ""
  def start
    while @input != 'exit' do
      welcome
      cities
      get_user_city
      breweries
      get_user_brewery
      get_exit_or_restart
    end
  end
  
  def welcome
    puts "Welcome to Find a Brewery CLI app".blue
    puts "\nYou can type exit at any time to close the app"
  end
    
  
  def cities
    puts "\nWhat city are you in?".green
    @cities = BeerProject::City.all
    puts "Choose your city by entering the number"
    @cities.sort_by {|city| city.name}.each.with_index(1) do |city, index| #sorts the array then iterates through it but when selecting option its in the old unorganised list.
      puts "#{index}. #{city.name}"
    end
  end
  
  def get_user_input
    @input = gets.strip.downcase
    exit if @input == "exit"
    @input = @input.to_i - 1
  end

  def get_user_city
    get_user_input
    if valid_input?(@input, @cities) 
      show_breweries_for(@input)
    else 
      puts "\nThat isn't a valid option, try again".red
      sleep(1)
      get_user_city
    end
  end
  
  def breweries
    puts "\nEnter the number of the brewery you want to know more about".green
    @breweries = BeerProject::Brewery.all
    @breweries.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address unless brewery.address == ""
    end
  end
  
  def get_user_brewery
    get_user_input
    if valid_input?(@input, @breweries)
      show_brewery_info(@input) 
    else
      puts "\nThat isn't a valid option, try again".red
      sleep(1)
      get_user_brewery
    end
  end
  
  def valid_input?(input, data)
    input < data.length && input >= 0 
  end
  
  def show_breweries_for(city_number)
    city = @cities[city_number]

    puts "\nShowing breweries in \n#{city.name}".blue
    BeerProject::Scraper.site = city.website
  end
  
  def show_brewery_info(brewery_number)
    brewery = @breweries[brewery_number]
  
    puts "\nShowing informaton for:\n#{brewery.name}".blue
    puts brewery.blurb
    puts "\nPhone:#{brewery.phone_number}" unless brewery.phone_number = ""
    puts "\nFind more information at their website: \n#{brewery.website}" unless brewery.website == ""
  end
  
  def get_exit_or_restart
    puts "\nDo you want to see any other cities? Enter Y or exit".green
    @input = gets.strip.downcase
    if @input == "y"
      BeerProject::Brewery.clear
      start
    elsif @input == 'exit'
      exit
    else 
      puts "Please enter Y or exit".red
      @input = gets.strip.downcase
    end
  end
  
end