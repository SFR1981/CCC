require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")


class RoomTest < MiniTest::Test

  def setup

    @room = Room.new("Room 1")
    @guest1 = Guest.new("Marti Pellow")


  end


  def test_room_has_name
    assert_equal("Room 1", @room.name())
  end


  def test_room_has_guests
    assert_equal([], @room.guests())
  end

  def test_room_has_songs
    assert_equal([], @room.songs())
  end

  def test_room_can_check_in_a_guest
    @room.check_in_one_guest(@guest1)
    assert_equal([@guest1], @room.guests())

  end




end
