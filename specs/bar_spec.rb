require("minitest/autorun")
require("minitest/rg")
require_relative("../bar.rb")

class BarTest < MiniTest::Test


  def setup
    drinks = {"beers" => 50}

    @bar = Bar.new("Hell Bar", drinks)

  end


  def test_bar_has_name
    assert_equal("Hell Bar", @bar.name())


  end



   def test_bar_has_till
     assert_equal(0, @bar.till())



   end



   def test_bar_has_drinks
     assert_equal({"beers" => 50}, @bar.drinks)


   end


end
