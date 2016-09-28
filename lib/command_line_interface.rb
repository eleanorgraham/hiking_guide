class CommandLineInteface
  BASE_PATH = "http://www.hikingupward.com/"

  def self.run
    make_trails
    add_trail_attributes
    greeting
    main_menu
  end

  def self.make_trails
    Trail.reset_all
    trails_array = Scraper.scrape_trail_list(BASE_PATH)
    Trail.create_from_collection(trails_array)
  end

  def self.add_trail_attributes
    Trail.all.each do |trail|
      attributes = Scraper.scrape_trail_profile(trail.profile_url)
      trail.add_trail_attributes(attributes)
    end
  end

  def self.greeting
    puts "           /Y                  "
    puts "          /  Y                 "
    puts "         /    Y   /Y           "
    puts "        /      Y /  Y          "
    puts "       /  /Y    /    Y /Y      "
    puts "      /  /  Y  /      /  Y     "
    puts "     /  /    Y/    /Y/    Y    "
    puts "    /  /      Y   /  Y     Y   "
    puts "_______________________________"
    puts "==============================="
    puts " H I T   T H E   T R A I L S ! "
    puts "==============================="
  end

  def self.main_menu
    puts "Where would you like to explore?"
    puts "(1) Maryland hikes"
    puts "(2) Pennsylvania hikes"
    puts "(3) North Carolina hikes"
    puts "(4) Virginia hikes"
    puts "(5) West Virginia hikes"
    puts "please enter 1-5:"
    input = gets.strip
    if input == "1"
      puts "Here is a list of trails in Maryland:"
      state_list(Trail.md)
      state_menu(Trail.md)
    elsif input == "2"
      puts "Here is a list of trails in Pennsylvania:"
      state_list(Trail.pa)
      state_menu(Trail.pa)
    elsif input == "3"
      puts "Here is a list of trails in North Carolina:"
      state_list(Trail.nc)
      state_menu(Trail.nc)
    elsif input == "4"
      puts "Here is a list of trails in Virgini:"
      state_list(Trail.va)
      state_menu(Trail.va)
    elsif input == "5"
      puts "Here is a list of trails in West Virginia:"
      state_list(Trail.wv)
      state_menu(Trail.wv)
    elsif input.upcase == "ALL TRAILS"
      display_all_trails
    elsif input.upcase == "EXIT"
      puts "Thanks for visiting -- Happy Trails!"
      greeting
    else
      puts "I'm not sure what you mean -- let's see if we can find the trail again!"
      puts "<< at any time you can exit by typing 'exit' >>"
      main_menu
    end
  end

  def self.state_list(state_trails_list)
    counter = 1
    state_trails_list.each do |trail|
      puts "(#{counter}) #{trail.name}"
      counter += 1
    end
  end

  def self.state_menu(state_trails_list)
    puts "Please type the number of any trail you'd like to learn more about"
    puts "Or if you wish to return to the main menu, type 'menu'"
    input = gets.strip
    if input.upcase == "MENU"
      main_menu
    else
      puts "I'm not sure what you mean -- let's see if we can find the trail again!"
      puts "<< at any time you can exit by typing 'exit' >>"
      state_menu(state_trails_list)
    end
  end

  def self.display_all_trails
    Trail.all.each do |trail|
      puts "#{trail.name.upcase}".colorize(:blue)
      puts "  state:".colorize(:light_blue) + " #{trail.state}"
      puts "  length:".colorize(:light_blue) + " #{trail.length}"
      puts "  hiking time:".colorize(:light_blue) + " #{trail.hiking_time}"
      puts "  elevation gain:".colorize(:light_blue) + " #{trail.elevation_gain}"
      puts "  link to map pdf:".colorize(:light_blue) + " #{trail.map_pdf_link}"
      puts "  trail description:".colorize(:light_blue) + " #{trail.description}"
      puts "----------------------".colorize(:green)
    end
  end

end
