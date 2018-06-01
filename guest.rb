require_relative("./song.rb")

class Guest

  attr_reader(:name, :wallet, :favourite_song)

  def initialize(name, wallet)

    @name = name
    @wallet = wallet
    #favourite = big_pile_of_songs.shuffle.pop() needs song obj
    @favourite_song = ""

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
    return "Whoo!"
  end




end
