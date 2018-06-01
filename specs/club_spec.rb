require("minitest/autorun")
require("minitest/rg")
require_relative("../club.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")


class ClubTest < MiniTest::Test

  def setup
    @room1 = Room.new("Rock", 5)
    @room2 = Room.new("80s", 5)
    @room3 = Room.new("Tunes from hell", 5)
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

  def test_customer_leaves
    @ccc.arriving_group([@guest1,@guest2,@guest3,@guest4,@guest5])
    @ccc.leaving_guest(@guest3)
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




end
