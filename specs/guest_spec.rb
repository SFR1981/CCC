require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../room.rb")
require_relative("../drinks.rb")
require_relative("../bar.rb")


class GuestTest < MiniTest::Test

  def setup
    @guest = Guest.new("Barry", 15.00)

    @song1 = Song.new("Bat out of hell - Meatloaf")
    @guest.overwrite_favourite_song(@song1)
    @beers = Drinks.new("Beer", 4.0)
    @drinks = {@beers => 50}
    @bar = Bar.new("Hell Bar", @drinks)
    @room = Room.new("Room 1", 5, @bar)
    @song2 = Song.new("Real American - Rick Derringer")
    @song3 = Song.new("Voices - Disturbed")
    @song4 = Song.new("Demanufacture - Fear Factory")
    @song5 = Song.new("Set you free - n-trance")
    @playlist = [@song1,@song2,@song3,@song4]



  end


  def test_guest_has_name
    assert_equal("Barry", @guest.name())
  end


  def test_guest_has_money
    assert_equal(15.00, @guest.wallet())

  end
  def test_guest_spends_money
    @guest.spend(5.00)
    assert_equal(10.00, @guest.wallet())
  end

  def test_guest_has_favourite_song
    assert_equal(@song1, @guest.favourite_song())


  end

  def test_guest_goes_Whoo
    assert_equal("Whoo!", @guest.whoo())

  end

  def test_guest_will_sing_
    assert_equal("Barry: I am singing Bat out of hell - Meatloaf", @guest.sings(@song1))

  end
  #
  # def test_guest_will_sing_favourite__fail_favourite_song_not_in_room
  #   @room.check_in_one_guest(@guest)
  #   @guest.sings()
  #   assert_equal("Barry: I am singing Bat out of hell - Meatloaf",@guest.sings())
  #
  # end
  # def test_guest_will_sing_favourite__fail_not_in_a_room
  #   @room.check_in_one_guest(@guest)
  #   @guest.sings()
  #   assert_equal("Barry: I am singing Bat out of hell - Meatloaf",@guest.sings())
  #
  # end





end
