require "spec_helper"

describe "Trail" do
  let!(:trail_index_array) {[
    {:name=>"Sunset Rocks", :state=>"PA", :profile_url=>"http://www.hikingupward.com/OPH/SunsetRocks/"},
    {:name=>"Elk Knob", :state=>"NC", :profile_url=>"http://www.hikingupward.com/NCSP/ElkKnob/"},
    {:name=>"Greenbrier SP", :state=>"MD", :profile_url=>"http://www.hikingupward.com/OMH/GreenbrierStatePark/"},
    {:name=>"Buzzard Hill", :state=>"VA", :profile_url=>"http://www.hikingupward.com/OVH/BuzzardHill/"},
    {:name=>"Riverbend", :state=>"VA", :profile_url=>"http://www.hikingupward.com/OVH/RiverBend/"},
    {:name=>"Harpers Ferry/Loudoun", :state=>"WV", :profile_url=>"http://www.hikingupward.com/OWVH/HarpersFerryLoudounHeights/"}
   ]}

 let!(:trail_hash) {{
   :length=>"10.5 mls",
   :hiking_time=>"6 hours plus a half hour for lunch",
   :elevation_gain=>"1,290 ft",
   :map_pdf_link=>"http://www.hikingupward.com/OMH/GreatHike/images/Map.pdf",
   :description=>"The Great Trail is a great trail to hike!"
 }}

  let!(:trail) {Trail.new({:name=>"Sunset Rocks", :state=>"PA", :profile_url=>"http://www.hikingupward.com/OPH/SunsetRocks/"})}

  after(:each) do
    Trail.class_variable_set(:@@all, [])
    Trail.class_variable_set(:@@md, [])
    Trail.class_variable_set(:@@pa, [])
    Trail.class_variable_set(:@@nc, [])
    Trail.class_variable_set(:@@va, [])
    Trail.class_variable_set(:@@wv, [])
  end

  describe "#new" do
    it "takes in an argument of a hash and sets that new trail's attributes using the key/value pairs of that hash." do
      expect{Trail.new({:name => "Raven Rocks", :state => "VA"})}.to_not raise_error
      expect(trail.name).to eq("Sunset Rocks")
      expect(trail.state).to eq("PA")
      expect(trail.profile_url).to eq("http://www.hikingupward.com/OPH/SunsetRocks/")
    end

    it "adds that new trail to the appropriate collection of trails by state" do
      expect(Trail.class_variable_get(:@@pa).first.name).to eq("Sunset Rocks")
      expect(Trail.class_variable_get(:@@pa).first.state).to eq("PA")
      expect(Trail.class_variable_get(:@@pa).first.profile_url).to eq("http://www.hikingupward.com/OPH/SunsetRocks/")
      expect(Trail.class_variable_get(:@@va).first.name).to eq("Buzzard Hill")
      expect(Trail.class_variable_get(:@@va).first.state).to eq("VA")
      expect(Trail.class_variable_get(:@@va).first.profile_url).to eq("http://www.hikingupward.com/OVH/BuzzardHill/")
      expect(Trail.class_variable_get(:@@va).last.name).to eq("Riverbend")
      expect(Trail.class_variable_get(:@@va).last.state).to eq("VA")
      expect(Trail.class_variable_get(:@@va).last.profile_url).to eq("http://www.hikingupward.com/OVH/RiverBend/")
    end

    it "adds that new trail to the Trail class' collection of all existing trails, stored in the `@@all` class variable." do
      expect(Trail.class_variable_get(:@@all).first.name).to eq("Sunset Rocks")
    end
  end

  describe ".create_from_collection" do
    it "uses the Scraper class to create new trails with the correct name and location." do
      Trail.class_variable_set(:@@all, [])
      Trail.create_from_collection(trail_index_array)
      expect(Trail.class_variable_get(:@@all).first.name).to eq("Sunset Rocks")
    end
  end

  describe "#add_trail_attributes" do
    it "uses the Scraper class to get a hash of a given trail's attributes and uses that hash to set additional attributes for that trail." do
      trail.add_trail_attributes(trail_hash)
      expect(trail.length).to eq("10.5 mls")
      expect(trail.hiking_time).to eq("6 hours plus a half hour for lunch")
      expect(trail.elevation_gain).to eq("1,290 ft")
      expect(trail.map_pdf_link).to eq("http://www.hikingupward.com/OMH/GreatHike/images/Map.pdf")
      expect(trail.description).to eq("The Great Trail is a great trail to hike!")
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
      Trail.class_variable_set(:@@all, [])
      expect(Trail.all).to match_array([])
    end
  end

end
