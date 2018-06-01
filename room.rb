class Room
attr_reader :name, :songs, :guests
  def initialize(name)

    @name = name
    @guests = []
    @songs = []


  end


  def check_in_one_guest(guest)

    @guests << guest

  end


end
