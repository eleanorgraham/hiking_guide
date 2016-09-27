require 'open-uri'

class Scraper

  def self.scrape_trail_list(list_url)
    page = Nokogiri::HTML(open(list_url))
    state_trails = {
      :md => page.css("#CollapsiblePanelOMH a"),
      :nc => page.css("#CollapsiblePanelONCH a"),
      :pa => page.css("#CollapsiblePanelOPH a"),
      :va => page.css("#CollapsiblePanelOVH a"),
      :wv => page.css("#CollapsiblePanelOWVH a"),
    }
    trail_array = []
    state_trails.each do |state, trails|
      trails.each do |trail|
        trail_array << {
          :name=> trail.children.text,
          :profile_url=> CommandLineInteface::BASE_PATH+trail.attributes["href"].value,
          :state=> "#{state}".upcase
          }
      end
    end
    trail_array
  end

  def self.scrape_trail_profile(profile_url)

  end

end
