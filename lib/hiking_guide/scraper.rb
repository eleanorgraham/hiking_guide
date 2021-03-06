#require 'open-uri'

class HikingGuide::Scraper

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
          :profile_url=> HikingGuide::CommandLineInteface::BASE_PATH+trail.attributes["href"].value,
          :state=> "#{state}".upcase
          }
      end
    end
    trail_array
  end

  def self.scrape_trail_profile(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    trail = {}
    reference = page.css("td").find_index {|td| td.text == "Camping"}

    page.css("td")[reference+1] != nil ?
      trail[:length] = page.css("td")[reference+1].text.split.join(" ") : "unknown"

    page.css("td")[reference+8].children[0] != nil ?
      trail[:hiking_time] = page.css("td")[reference+8].children[0].text.split.join(" ") : "unknown"

    page.css("td")[reference+8].children[2] != nil ?
      trail[:elevation_gain] = page.css("td")[reference+8].children[2].text.split.join(" ") : "unknown"

    page.css("p") != nil ?
      trail[:description] = clean_description(page).join(" ").split.join(" ")[0..750].gsub(/\s\w+\s*$/, '...') : "unknown"

    trail[:map_pdf_link] = profile_url+("images/Map.pdf")

    trail
  end

  def self.clean_description(page)
    paragraphs = []
    page.css("p").each do |paragraph|
      paragraphs << paragraph.text
    end
    paragraphs.delete_if {|p| p.include? ("Printable Topo Hike Map")}
    paragraphs.delete_if {|p| p.include? ("(<!--")}
    paragraphs
  end

end
