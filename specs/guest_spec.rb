require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")
require_relative("../song.rb")


class GuestTest < MiniTest::Test

  def setup
    @guest = Guest.new("Barry", 15.00)

    @song1 = Song.new("Bat out of hell - Meatloaf")
    @guest.overwrite_favourite_song(@song1)


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





end
