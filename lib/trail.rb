class Trail
  attr_accessor :name, :state, :profile_url, :length, :hiking_time, :elevation_gain, :map_pdf_link, :description
  @@all = []
  @@md = []
  @@pa = []
  @@nc = []
  @@va = []
  @@wv = []

  def initialize(trail_hash)
    trail_hash.each {|key, value| self.send("#{key}=", "#{value}")}
    Trail.all << self
    Trail.update_state_lists
  end

  def self.update_state_lists
    self.all.each do |trail|
      case trail.state
      when "MD"
        self.md << trail
      when "PA"
        self.pa << trail
      when "NC"
        self.nc << trail
      when "VA"
        self.va << trail
      when "WV"
        self.wv << trail
      end
    end
    binding.pry
  end

  def self.all
    @@all
  end

  def self.md
    @@md
  end

  def self.pa
    @@pa
  end

  def self.nc
    @@nc
  end

  def self.va
    @@va
  end

  def self.wv
    @@wv
  end

end
