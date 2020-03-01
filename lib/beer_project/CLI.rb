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
    puts "Welcome to Find a Brewery CLI app"
    puts "\nType exit at any time to close the app"
  end
    
  
  def cities
    puts "\nWhat city are you in?"
    @cities = BeerProject::City.all
    puts "Choose your city by entering the number\n"
    @cities.each.with_index(1) do |city, index|
      puts "#{index}. #{city.name}"
    end
  end
  
  def get_user_city
    @input = gets.strip.downcase
    exit if @input == "exit"
    begin
      chosen_city_number = @input.to_i - 1
      rescue 
      puts "\nThat isn't a valid option"
      sleep(1)
      get_user_city
    end
    if valid_input?(chosen_city_number, @cities) 
      show_breweries_for(chosen_city_number)
    else 
      puts "\nThat isn't a valid option"
      sleep(1)
      get_user_city
    end
  end
  
  def breweries
    puts "\nEnter the number of the brewery you want to know more about"
    @breweries = BeerProject::Brewery.all
    @breweries.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address unless brewery.address == ""
    end
  end
  
  def get_user_brewery
    @input = gets.strip.downcase
    exit if @input == "exit"
    begin
      chosen_brewery_number = @input.to_i - 1
      rescue
      puts "\nThat isn't a valid option"
      sleep(1)
      get_user_brewery
    end
    if valid_input?(chosen_brewery_number, @breweries)
      show_brewery_info(chosen_brewery_number) 
    else
      puts "\nThat isn't a valid option"
      sleep(1)
      get_user_brewery
    end
  end
  
  def valid_input?(input, data)
    input < data.length && input >= 0 
  end
  
  def show_breweries_for(city_number)
    puts "\nShowing breweries in \n#{@cities[city_number].name}"
    BeerProject::Scraper.site = @cities[city_number].website
  end
  
  def show_brewery_info(brewery_number)
    puts "\nShowing informaton for:\n#{@breweries[brewery_number].name}"
    puts @breweries[brewery_number].blurb
    puts "\nPhone:#{@breweries[brewery_number].phone_number}" unless @breweries[brewery_number].phone_number = ""
    puts "\nFind more information at their website: #{@breweries[brewery_number].website}" unless @breweries[brewery_number].website == ""
    #puts "Would like to go to their website? Enter Y or N" unless @breweries[brewery_number].website == ""
    #@input = gets.strip.downcase
    #if @input == "y"
     #system("open", "#{@breweries[brewery_number].website}")
    #end
  end
  
  def get_exit_or_restart
    puts "\nDo you want to see any other cities? Enter Y or exit"
    @input = gets.strip.downcase
    if @input == "y"
      BeerProject::Brewery.clear
      start
    elsif @input == 'exit'
      exit
    else 
      puts "Please enter Y or exit"
      @input = gets.strip.downcase
    end
  end
  
end