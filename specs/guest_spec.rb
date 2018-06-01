require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")


class GuestTest < MiniTest::Test

  def setup
    @guest = Guest.new("Barry", 15.00)




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


end
