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

  def check_in_multi_guests(guests)

     @guests += guests
  end

  def check_out_one_guest(guest)
    removal = [guest]
    @guests -= removal

  end

  def check_out_multi_guest(guests)
    removal = guests
    @guests -= removal
  end

  def add_song(song)
    @songs << song

  end


end
