require_relative("./song.rb")

class Guest

  attr_reader(:name, :wallet, :favourite_song, :drinks_drank)
  attr_writer(:drinks_drank)

  def initialize(name, wallet)

    @name = name
    @wallet = wallet
    #favourite = big_pile_of_songs.shuffle.pop() needs song obj
    @favourite_song = nil
    @drinks_drank = 0

  end


  def spend(amount)

    @wallet -= amount

  end

  def favourite_song
    return @favourite_song
  end

  def overwrite_favourite_song(song)
    @favourite_song = song
  end

  def whoo
    p "#{@name}: Whoo!"
    return "Whoo!"

  end

  def sings(song)
    p "#{@name}: I am singing #{song.title_and_artist()}"
    #return "#{@name}: I am singing #{song.title_and_artist()}"



  end




end
