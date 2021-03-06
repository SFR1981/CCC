require("minitest/autorun")
require("minitest/rg")
require_relative("../club.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require_relative("../drinks.rb")
require_relative("../bar.rb")


class ClubTest < MiniTest::Test

  def setup
    @beers = Drinks.new("Beer", 4.0)
    drinks = {@beers => 50}
    @bar1 = Bar.new("Rock Bar", drinks)
    @bar2 = Bar.new("80s Bar", drinks)
    @bar3 = Bar.new("Hell Bar", drinks)
    @room1 = Room.new("Rock", 5, @bar1)
    @room2 = Room.new("80s", 5, @bar2)
    @room3 = Room.new("Tunes from hell", 5, @bar3)
    @song1 = Song.new("Last Resort - Papa Roach")
    @song2 = Song.new("Real American - Rick Derringer")
    @song3 = Song.new("Voices - Disturbed")
    @song4 = Song.new("Demanufacture - Fear Factory")
    @rock = [@song1, @song2, @song3, @song4]
    @song5 = Song.new("China in your hand - T'Pau")
    @song6 = Song.new("Heaven is a place on Earth - Belinda Carlisle")
    @song7 = Song.new("I think we're alone now - Tiffany")
    @song8 = Song.new("A little respect - Erasure")
    @eighties = [@song5, @song6, @song7, @song8]
    @song9 = Song.new("I am the music man - Black lace")
    @song10 = Song.new("Bat out of hell - Meatloaf")
    @song11= Song.new("The time warp - O'Brien, Quinn, Campbell, Gray")
    @song12 = Song.new("Summer nights - John Travolta & Olivia Newton-John")
    @hell = [@song9, @song10, @song11, @song12]
    @room1.add_playlist(@rock)
    @room2.add_playlist(@eighties)
    @room3.add_playlist(@hell)
    @rooms = [@room1, @room2, @room3]
    @ccc = Club.new(@rooms, 5.00)
    @guest1 = Guest.new("Marti Pellow", 100.00)
    @guest2 = Guest.new("Dave", 25.00)
    @guest3 = Guest.new("Donatello", 50.00)
    @guest4 = Guest.new("Gordon", 20.00)
    @guest5 = Guest.new("Shirley", 20.00)
    @guest6 = Guest.new("Sonia", 20.00)



  end


  def test_club_has_rooms
    assert_equal(@rooms, @ccc.rooms())


  end


  def test_club_has_entry_fee

    assert_equal(5.00, @ccc.cost())



  end


  def test_club_has_guests
    assert_equal([], @ccc.guests())
  end


  def test_club_return_contents_of_till
    assert_equal(0, @ccc.till())

  end

  def test_club_has_customer_arrive
    @ccc.arriving_customer(@guest1)
    assert_equal([@guest1], @ccc.guests())


  end

  def test_club_gets_money_from_arriving_customer
    @ccc.arriving_customer(@guest1)
    assert_equal(5.00, @ccc.till())
    assert_equal(95.00, @guest1.wallet())



  end

  def test_club_has_customers_arrive
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    assert_equal([@guest1,@guest2,@guest3,@guest4,@guest5],@ccc.guests())

  end

  def test_club_gets_money_from_arriving_group
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    assert_equal(25.00, @ccc.till())
    assert_equal(95.00, @guest1.wallet())
    assert_equal(20.00, @guest2.wallet())
    assert_equal(45.00, @guest3.wallet())
    assert_equal(15.00, @guest4.wallet())
    assert_equal(15.00, @guest5.wallet())



  end

  def test_customer_leaves
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    @room2.check_in_one_guest(@guest3)
    @ccc.leaving_guest(@guest3)
    assert_equal([],@room2.guests())
    assert_equal([@guest1,@guest2,@guest4,@guest5],@ccc.guests())


  end

  def test_group_leaves
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    @ccc.leaving_group([@guest3, @guest1])
    assert_equal([@guest2,@guest4,@guest5], @ccc.guests())

  end

  def test_club_guest_enters_room
    @room1.check_in_one_guest(@guest5)
    assert_equal([@guest5], @room1.guests())

  end

  def test_room_has_songs
    assert_equal(@rock, @room1.songs())

  end


  def test_club_can_track_total_revenue
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    @room1.check_in_multi_guests([@guest1,@guest2])
    @room2.check_in_multi_guests([@guest3,@guest4])
    @room3.check_in_one_guest(@guest5)
    @room1.guests_visits_bar(@guest1, @beers)
    @room1.guests_visits_bar(@guest2, @beers)
    @room2.guests_visits_bar(@guest3, @beers)
    @room2.guests_visits_bar(@guest4, @beers)
    @room3.guests_visits_bar(@guest5, @beers)
    @room3.guests_visits_bar(@guest5, @beers)
    assert_equal(49.00, @ccc.total_revenue())

  end

  def test_club_can_track_what_room_a_customer_is_in
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    @room1.check_in_multi_guests([@guest1,@guest2])
    @room2.check_in_multi_guests([@guest3,@guest4])
    @room3.check_in_one_guest(@guest5)
    assert_equal(@room1, @ccc.what_room(@guest2))

  end

   def test_guests_can_not_be_in_more_than_one_room
     @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
     @room1.check_in_multi_guests([@guest1,@guest2])
     @room2.check_in_multi_guests([@guest3,@guest4])
     @room3.check_in_multi_guests([@guest5,@guest1])
     assert_equal(@room1, @ccc.what_room(@guest1))

   end





end
