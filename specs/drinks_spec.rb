require("minitest/autorun")
require("minitest/rg")
require_relative("../drinks.rb")

class DrinksTest < MiniTest::Test

  def setup
    @beers = Drinks.new("Beer", 4.0)

  end

  def test_drinks_have_name
    assert_equal("Beer", @beers.name())

  end


  def test_drinks_have_price
    assert_equal(4.0, @beers.cost())


  end

end
