class BeerProject::CLI
  @input = ""
  def start
    #need to start a loop
    while @input != 'exit' do
    puts "Welcome to Find a Brewery CLI app"
    puts "\nType exit at any time to close the app"
    cities
    get_user_city
    breweries
    get_user_brewery
    gets_exit_or_restart
    end
  end
  
  def cities
    puts "\nWhat city are you in?"
    @cities = BeerProject::City.all
    puts "Choose your city by entering the number\n"
    @cities.each.with_index(1) do |city, index|
      puts "#{index}. #{city.name}"
    end
  end
  
  def breweries
    #second loop we get first loops breweries
    puts "\nEnter the number of the brewery you want to know more about"
    @breweries = BeerProject::Brewery.all
    @breweries.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address unless brewery.address == ""
    end
  end
  
  def get_user_brewery
    @input = gets.strip
    if @input == "exit"
      exit
    else
    begin
    chosen_brewery_number = @input.to_i-1
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
      #can we combine these two error handlers into one?
    end
    end
  end
  #this is a duplicate from below can we abstract and combine?
  def get_user_city
    @input = gets.strip
    if @input == "exit"
      exit
    else
      begin
        chosen_city_number = @input.to_i-1
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
      #can we combine these two error handlers into one?
    end
    end
  end
  #this is a duplicate from above can we abstract and combine?
  
  def valid_input?(input, data)
    input.to_i <= data.length && input.to_i >= 0 
  end
  
  def show_breweries_for(city_number)
    puts "\nShowing breweries in \n#{@cities[city_number].name}"
    BeerProject::Scraper.site = @cities[city_number].website
  end
  
  def show_brewery_info(brewery_number)
    puts "\nShowing informaton for:\n#{@breweries[brewery_number].name}"
    #do we need an address shown here or on intial puts?
    puts @breweries[brewery_number].blurb
    puts "\nPhone:#{@breweries[brewery_number].phone_number}" unless @breweries[brewery_number].phone_number = ""
    puts "\nFind more information at their website: #{@breweries[brewery_number].website}" unless @breweries[brewery_number].website == ""
    #can we open website if they ask to?, or even open in maps with address?
  end
  
  def gets_exit_or_restart
    puts "Do you want to see any other cities? Y or exit"
    @input = gets.strip
    start if @input == "Y"
  end
  
end