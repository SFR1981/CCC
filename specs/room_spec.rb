require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require_relative("../bar.rb")
require_relative("../drinks.rb")


class RoomTest < MiniTest::Test

  def setup

    @beers = Drinks.new("Beer", 4.0)
    @drinks = {@beers => 50}
    @bar = Bar.new("Hell Bar", @drinks)
    @room = Room.new("Room 1", 5, @bar)
    @room2 = Room.new("Room 2", 5, @bar)
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
    @song5 = Song.new("Set you free - n-trance")
    @playlist = [@song1,@song2,@song3,@song4]
    @guest2.overwrite_favourite_song(@song3)


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
    @room.check_in_one_guest(@guest1)
    @room.check_out_one_guest(@guest1)
    assert_equal([], @room.guests())

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

  def test_room_has_playlist_added


    @room.add_playlist(@playlist)
    assert_equal(@playlist, @room.songs())
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


  def test_room_check_in_guest_guest_whoos__pass
    @guest1.overwrite_favourite_song(@song3)
    @room.add_playlist(@playlist)
    @room.check_in_one_guest(@guest1)
    assert_equal(1, @room.whoo_count())


   end

   def test_room_check_in_guest_guest_whoos__fail
     @guest1.overwrite_favourite_song(@song5)
     @room.add_playlist(@playlist)
     @room.check_in_one_guest(@guest1)
     assert_equal(0, @room.whoo_count())


    end

    def test_room_check_in_guest_guest_whoos__group
      @guest1.overwrite_favourite_song(@song1)
      @guest2.overwrite_favourite_song(@song2)
      @guest3.overwrite_favourite_song(@song3)
      @room.add_playlist(@playlist)
      @room.check_in_multi_guests([@guest1,@guest2,@guest3])

      assert_equal(3, @room.whoo_count())


     end

     def test_bar_is_in_room
       assert_equal(@bar, @room.bar())

     end
     def test_stock_count
       assert_equal(50, @room.bar.drinks[@beers])

     end

    def test_guests_can_buy_drinks_from_bar_in_room
       @room.check_in_one_guest(@guest1)
       @room.guests_visits_bar(@guest1,@beers)
      assert_equal(49, @room.bar.drinks[@beers])
      assert_equal(4.0, @room.bar.till())
       assert_equal(96.00, @guest1.wallet())

    end

    def test_guests_can_not_buy_drinks_from_bar_in_room_they_are_not_inside

       @room.guests_visits_bar(@guest1,@beers)
      assert_equal(50, @room.bar.drinks[@beers])
      assert_equal(0, @room.bar.till())
       assert_equal(100.00, @guest1.wallet())

    end


    def test_guest_will_sing_favourite
      @room.add_playlist(@playlist)
      @room.check_in_one_guest(@guest2)
      @room.guest_wants_to_sing(@guest2)
      assert_equal("Dave: I am singing Voices - Disturbed",@room.guest_wants_to_sing(@guest2))

    end

    def test_guest_will_sing_favourite__fail_song_not_present
      @room.add_playlist([@song1])
      @room.check_in_one_guest(@guest2)
      @room.guest_wants_to_sing(@guest2)
      assert_nil(@room.guest_wants_to_sing(@guest2))

    end

    def test_guest_will_sing_favourite__fail_guest_not_present
      @room.add_playlist([@playlist])
      @room.check_in_one_guest(@guest1)
      @room.guest_wants_to_sing(@guest2)
      assert_nil(@room.guest_wants_to_sing(@guest2))

    end








end
