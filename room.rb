class Room
attr_reader :name, :songs, :guests, :capacity, :whoo_count, :bar
attr_writer :songs
  def initialize(name, capacity, bar)

    @name = name
    @guests = []
    @songs = []
    @capacity = capacity
    @whoo_count = 0
    @bar = bar


  end


  def check_in_one_guest(guest)
    return if @guests.length() == @capacity
      @guests << guest
      p "#{guest.name()} has checked into the #{@name} room"
      if @songs.include?(guest.favourite_song())
        guest.whoo()
        @whoo_count +=1
        @guests.uniq!
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

      # removal = [guest]
      @guests.delete(guest)


      p "#{guest.name()} has left the #{self.name()} room #{@guests.length()} remain"


  end

  def check_out_multi_guest(guests)
    removal = guests
    @guests -= removal
    for guest in @guests
      p "#{guest.name()} has left the #{self.name()} room #{@guests.length()} remain"
    end
  end

  def add_song(song)
    @songs << song

  end

  def add_playlist(playlist)
    @songs += playlist

  end

  def guests_visits_bar(guest, drink)
    if @guests.include?(guest)
      @bar.sells_drink(guest, drink)
    end
  end

  def guest_wants_to_sing(guest)
    if @songs.include?(guest.favourite_song())
      guest.sings(guest.favourite_song())
    end
  end




end
