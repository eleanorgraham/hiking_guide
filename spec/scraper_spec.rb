require "spec_helper"

describe "Scraper" do

  let!(:trail_index_array) {[
    {:name=>"Billy Goat Trail", :state=>"MD", :profile_url=>"http://www.hikingupward.com/OMH/BillyGoatTrail/"},
    {:name=>"Belle Isle", :state=>"VA", :profile_url=>"http://www.hikingupward.com/OVH/BelleIsle/"},
    {:name=>"Cranny Crow/Big Ridge", :state=>"WV", :profile_url=>"http://www.hikingupward.com/OWVH/CrannyCrowBigRidge/"}
    ]}

  let!(:trail_md_billy_goat) {{
    :length=>"7.8 mls",
    :hiking_time=>"4.5 hours plus a half hour for lunch",
    :elevation_gain=>"280 ft",
    :map_pdf_link=>"http://www.hikingupward.com/OMH/BillyGoatTrail/images/Map.pdf",
    :description=>"The Billy Goat Trail is one of the most well known hikes in the Metro D.C. area, and for good reason. With nearly a mile of fun rock-hopping, and spectacular views of the Potomac River along the way, this circuit is loads of fun with plenty to see. We have the circuit rated as only a 3 for difficulty, but be prepared to jump from rock to rock."
  }}

  let!(:trail_va_belle_isle) {{
    :length=>"2.1 mls",
    :hiking_time=>"1.0 hours plus a half hour for lunch",
    :elevation_gain=>"55 ft",
    :map_pdf_link=>"http://www.hikingupward.com/OVH/BelleIsle/images/Map.pdf",
    :description=>"Belle Isle is a deceptively named, family friendly, wheelchair accessible hike in the middle of the James River with the downtown skyline of Richmond, VA visible in the background. If you just walked around and looked only at the river, the trees, the birds, the climbing cliffs, etc, you would certainly agree that it is a “Belle Isle”. On the other hand if you read some of the posted signs and looked around at the evidence of its prior use, you might be transported back to a time when it was not a Belle Isle: a granite quarry pit, a power plant, an iron milling factory, an iron foundry, and the most haunting of all – A Civil War prison camp where over 1,000 Union soldiers died from deprivation."
  }}

  let!(:trail_wv_cranny_crow_big_ridge) {{
    :length=>"11.1 mls",
    :hiking_time=>"5.5 hours plus a half hour for lunch",
    :elevation_gain=>"2,150 ft ",
    :map_pdf_link=>"http://www.hikingupward.com/OWVH/CrannyCrowBigRidge/images/Map.pdf",
    :description=>"West Virginia, renowned for its state park system, has another hidden gem in the Lost River State Park. The Cranny Crow/Big Ridge hike is a combination of a loop and out/back. With Cranny Crow, Cheeks Rock, and the Big Ridge vistas, as well as the ridge meadow, this hike has beautiful scenery around every corner in its trail system."
  }}

  describe "#scrape_trail_list" do
    it "is a class method that scrapes the trail index page and a returns an array of hashes in which each hash represents one trail" do
      index_url = "http://www.hikingupward.com/"
      scraped_trails = Scraper.scrape_trail_list(index_url)
      expect(scraped_trails).to be_a(Array)
      expect(scraped_trails.first).to have_key(:state)
      expect(scraped_trails.first).to have_key(:name)
      expect(scraped_trails).to include(trail_index_array[0], trail_index_array[1], trail_index_array[2])
    end
  end

  describe "#scrape_trail_profile" do
    it "is a class method that scrapes a trails's profile page and returns a hash of attributes describing a particular trail" do
      profile_url = "http://www.hikingupward.com/OVH/BelleIsle/"
      scraped_trail = Scraper.scrape_trail_profile(profile_url)
      expect(scraped_trail).to be_a(Hash)
      expect(scraped_trail).to match(trail_va_belle_isle)
    end
  end

end
