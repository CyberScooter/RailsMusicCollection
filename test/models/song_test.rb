require 'test_helper'

class SongTest < ActiveSupport::TestCase
  test "should accept valid song" do
    song = Song.new

    song.name = "Song 1"
    song.artist = "Artist 1"
    song.year = 05-03-2019

    song.save
    assert song.valid?

  end

  test "should not save invalid album" do
    song = Song.new

    song.name = ""
    song.artist = ""

    song.save
    assert_not song.valid?

  end
end
