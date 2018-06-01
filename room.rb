class Room
attr_reader :name, :songs, :guests, :capacity, :whoo_count
attr_writer :songs
  def initialize(name, capacity)

    @name = name
    @guests = []
    @songs = []
    @capacity = capacity
    @whoo_count = 0


  end


  def check_in_one_guest(guest)
    return if @guests.length() == @capacity
      @guests << guest
      if @songs.include?(guest.favourite_song())
        guest.whoo()
        @whoo_count +=1
      end

  end

  def check_in_multi_guests(multiple_guests)
    multiple_guests.each do |guest|
      return if @guests.length() == @capacity
        @guests << guest
        if @songs.include?(guest.favourite_song())
          guest.whoo()
          @whoo_count +=1
        end
    
    end

     #@guests += guests
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

  def add_playlist(playlist)
    @songs += playlist

  end


end
