require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")


class RoomTest < MiniTest::Test

  def setup

    @room = Room.new("Room 1", 5)
    @guest1 = Guest.new("Marti Pellow", 100.00)
    @guest2 = Guest.new("Dave", 25.00)
    @guest3 = Guest.new("Donatello", 50.00)
    @guest4 = Guest.new("Gordon", 20.00)
    @guest5 = Guest.new("Shirley", 20.00)
    @guest6 = Guest.new("Sonia", 20.00)
    @song1 = Song.new("Last Resort - Papa Roach")
    @song2 = Song.new("Real American - Rick Derringer")
    @song3 = Song.new("Voices - Disturbed")
    @song4 = Song.new("Demanufacture - Fear Factory")


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

  def test_room_can_check_in_multiple_guests
    @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
    assert_equal([@guest1,@guest2,@guest3,@guest4], @room.guests())

  end


  def test_room_can_check_out_one_guest
    @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
    @room.check_out_one_guest(@guest2)
    assert_equal([@guest1, @guest3, @guest4], @room.guests())
  end

  def test_room_can_check_out_multiple_guests
    @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
    @room.check_out_multi_guest([@guest4,@guest2])
    assert_equal([@guest1, @guest3], @room.guests())
  end

  def test_room_can_have_songs_added
    @room.add_song(@song2)
    assert_equal([@song2], @room.songs())

  end

  def test_room_has_a_capacity
    assert_equal(5, @room.capacity())

  end

   def test_room_check_in_guest__not_at_capacity
     @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
     @room.check_in_one_guest(@guest5)
     assert_equal([@guest1,@guest2,@guest3,@guest4,@guest5], @room.guests())

   end


   def test_room_check_in_guest__at_capacity
     @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
     @room.check_in_one_guest(@guest5)
     @room.check_in_one_guest(@guest6)
     assert_equal([@guest1,@guest2,@guest3,@guest4,@guest5], @room.guests())

   end

   def test_room_check_in_guest__at_capacity_multi
     @room.check_in_one_guest(@guest5)
     @room.check_in_one_guest(@guest6)
     @room.check_in_multi_guests([@guest1,@guest2,@guest3,@guest4])
     assert_equal([@guest5,@guest6,@guest1,@guest2,@guest3], @room.guests())

   end



end
