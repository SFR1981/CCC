require("minitest/autorun")
require("minitest/rg")
require_relative("../bar.rb")
require_relative("../drinks.rb")
require_relative("../guest.rb")

class BarTest < MiniTest::Test


  def setup
    @beers = Drinks.new("Beer", 4.0)
    drinks = {@beers => 50}
    @bar = Bar.new("Hell Bar", drinks)
    @guest1 = Guest.new("Marti Pellow", 100.00)

  end


  def test_bar_has_name
    assert_equal("Hell Bar", @bar.name())


  end



   def test_bar_has_till
     assert_equal(0, @bar.till())



   end



   def test_bar_has_drinks
     assert_equal({@beers => 50}, @bar.drinks)

   end

   def test_bar_sells_drink
     @bar.sells_drink(@guest1, @beers)
    assert_equal(49, @bar.drinks[@beers])
    assert_equal(4.0, @bar.till())
     assert_equal(96.00, @guest1.wallet())
     assert_equal(1, @guest1.drinks_drank())
   end





end
