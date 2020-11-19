require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "should accept valid album" do
    album = Album.new

    album.name = "Album 1"
    album.description = "Chill songs"

    album.save
    assert album.valid?

  end

  test "should not accept invalid album" do
    album = Album.new

    album.name = ""
    album.description = ""

    album.save
    assert_not album.valid?

  end
end
