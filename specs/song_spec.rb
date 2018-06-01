require("minitest/autorun")
require("minitest/rg")
require_relative("../song.rb")


class SongTest < MiniTest::Test

  def setup
    @song = Song.new("Headstrong - Trapt")




  end


  def test_song_has_title
    assert_equal("Headstrong - Trapt", @song.title_and_artist())
  end


end
