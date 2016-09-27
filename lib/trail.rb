class Trail
  attr_accessor :name, :state, :profile_url, :length, :hiking_time, :elevation_gain, :map_pdf_link, :description
  @@all = []

  def initialize(trail_hash)
    trail_hash.each {|key, value| self.send("#{key}=", "#{value}")}
    @@all << self
  end

  def create_state_lists

  end

  def self.all
    @@all
  end

end
