class HikingGuide::CommandLineInteface
  BASE_PATH = "http://www.hikingupward.com/"

  def self.run
    greeting
    main_menu
  end

  def self.make_trails
    HikingGuide::Trail.reset_all
    trails_array = HikingGuide::Scraper.scrape_trail_list(BASE_PATH)
    HikingGuide::Trail.create_from_collection(trails_array)
  end

  def self.add_trail_attributes
    HikingGuide::Trail.all.each do |trail|
      attributes = HikingGuide::Scraper.scrape_trail_profile(trail.profile_url)
      trail.add_trail_attributes(attributes)
    end
  end

  def self.greeting
    puts "Setting up your command line trail guide -"
    puts "Please wait a minute while we gather the trail details..."
    sleep(1)
    puts "    /\\      ".light_red.on_red
    puts "   /  \\     ".light_red.on_red
    puts "  /    \\/\\  ".light_red.on_red
    puts " /     /  \\ ".light_red.on_red
    sleep(1)
    make_trails
    puts "getting closer..."
    puts "          /\\     ".light_yellow.on_yellow
    puts "     /\\  /  \\    ".light_yellow.on_yellow
    puts "    /  \\/    \\   ".light_yellow.on_yellow
    puts "   /    \\/\\   \\  ".light_yellow.on_yellow
    puts "  /     /  \\   \\ ".light_yellow.on_yellow
    puts " /     /    \\   \\".light_yellow.on_yellow
    add_trail_attributes
    puts "All set!"
    sleep(1)
    hit_the_trails
    puts ""
    puts "Welcome to Hiking Guide!".black.on_green
    puts ""
    puts "The information in Hiking Guide comes from a volunteer organization called Hiking Upward (http://www.hikingupward.com/). If you find the information useful, please consider volunteering as a Trail Contributer, or donating to the organization."
    puts ""
  end

  def self.hit_the_trails
    puts "           /\\                  ".light_green.on_green
    puts "          /  \\                 ".light_green.on_green
    puts "         /    \\   /\\           ".light_green.on_green
    puts "        /      \\ /  \\          ".light_green.on_green
    puts "       /  /\\    /    \\ /\\      ".light_green.on_green
    puts "      /  /  \\  /      /  \\     ".light_green.on_green
    puts "     /  /    \\/    /\\/    \\    ".light_green.on_green
    puts "    /  /      \\   /  \\     \\   ".light_green.on_green
    puts "_______________________________".black.on_green
    puts "===============================".black.on_green
    puts " H I T   T H E   T R A I L S ! ".light_green.on_green
    puts "===============================".black.on_green
  end

  def self.main_menu
    puts "Where would you like to explore?".black.on_green
    puts "(1) Maryland hikes"
    puts "(2) Pennsylvania hikes"
    puts "(3) North Carolina hikes"
    puts "(4) Virginia hikes"
    puts "(5) West Virginia hikes"
    puts "please enter 1-5:"
    input = gets.strip
    if input == "1"
      puts "Here is a list of trails in Maryland:".black.on_green
      state_menu(HikingGuide::Trail.md)
    elsif input == "2"
      puts "Here is a list of trails in Pennsylvania:".black.on_green
      state_menu(HikingGuide::Trail.pa)
    elsif input == "3"
      puts "Here is a list of trails in North Carolina:".black.on_green
      state_menu(HikingGuide::Trail.nc)
    elsif input == "4"
      puts "Here is a list of trails in Virgini:".black.on_green
      state_menu(HikingGuide::Trail.va)
    elsif input == "5"
      puts "Here is a list of trails in West Virginia:".black.on_green
      state_menu(HikingGuide::Trail.wv)
    elsif input.upcase == "ALL TRAILS"
      display_all_trails
    elsif input.upcase == "EXIT"
      exit
    else
      puts "I'm not sure what you mean -- let's see if we can find the trail again!".black.on_green
      puts "<< at any time you can exit by typing 'exit' >>".black.on_green
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
    state_list(state_trails_list)
    puts "Please type the number of any trail you'd like to learn more about"
    puts "Or if you wish to return to the main menu, type 'menu'"
    input = gets.strip
    if input.to_i > 0 && input.to_i <= state_trails_list.size
      display_trail_details(state_trails_list[input.to_i-1])
      puts "Would you like to read about another of these trails? (y/n)"
      response = gets.strip
      if response.upcase == "Y"
        state_menu(state_trails_list)
      elsif response.upcase == "EXIT"
        exit
      else
        main_menu
      end
    elsif input.upcase == "MENU"
      main_menu
    elsif input.upcase == "EXIT"
      exit
    else
      puts "I'm not sure what you mean -- let's see if we can find the trail again!".black.on_green
      puts "<< at any time you can exit by typing 'exit' >>".black.on_green
      state_menu(state_trails_list)
    end
  end

  def self.exit
    puts "Thanks for visiting -- Happy Trails!"
    hit_the_trails
  end

  def self.display_trail_details(trail)
    puts "----------------------".colorize(:light_green).on_green
    puts " #{trail.name.upcase} ".colorize(:black).on_green
    puts "  state:".colorize(:black).on_green + " #{trail.state}"
    puts "  length:".colorize(:black).on_green + " #{trail.length}"
    puts "  hiking time:".colorize(:black).on_green + " #{trail.hiking_time}"
    puts "  elevation gain:".colorize(:black).on_green + " #{trail.elevation_gain}"
    puts "  link to map pdf:".colorize(:black).on_green + " #{trail.map_pdf_link}"
    puts "  trail description:".colorize(:black).on_green + " #{trail.description}"
    puts "  * * * * * * *  ".colorize(:light_green)
    puts "To read more about this trail, please visit #{trail.profile_url}"
    puts "----------------------".colorize(:light_green).on_green
  end

  def self.display_all_trails
    HikingGuide::Trail.all.each do |trail|
      display_trail_details(trail)
    end
    main_menu
  end

end