class CommandLineInteface
  BASE_PATH = "http://www.hikingupward.com/"

  def self.run
    make_trails
    add_trail_attributes
    while input != "exit"
      greeting
      main_menu
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
    puts "<< at any time you can exit by typing 'exit' >>"
  end

  def self.main_menu
    puts "Where would you like to explore?"
    puts "(1) Maryland hikes"
    puts "(2) Pennsylvania hikes"
    puts "(3) North Carolina hikes"
    puts "(4) Virginia hikes"
    puts "(5) West Virginia hikes"
    puts "please enter 1-5 to get started:"
    input = gets.strip
    case input
    when 1
      md_menu
    when 2
      pa_menu
    when 3
      nc_menu
    when 4
      va_menu
    when 5
      wv_menu
    else
      puts "I'm not sure what you mean -- let's see if we can find the trail again!"
      self.main_menu
    end
  end

  def self.make_trails
    trails_array = Scraper.scrape_trail_list(BASE_PATH)
    Trail.create_from_collection(trails_array)
  end

  def self.add_trail_attributes
    Trail.all.each do |trail|
      attributes = Scraper.scrape_trail_profile(trail.profile_url)
      trail.add_trail_attributes(attributes)
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
