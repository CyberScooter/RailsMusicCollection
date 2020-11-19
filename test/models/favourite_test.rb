require 'test_helper'

class FavouriteTest < ActiveSupport::TestCase
  test "should save favourite" do
    #only using for model level testing only, to test relationship
    user = User.new
    user.username = "Test"
    user.password = "Test123"

    album = Album.new
    album.name = "Album 1"
    album.description = "Chill album"

    favourite = Favourite.new
    favourite.user = user
    favourite.album = album

    assert favourite.save
  end

  test "should not save invalid favourite" do
    user = User.new
    user.username = "Test"
    user.password = "Test123"

    album = Album.new
    album.name = "Album 1"
    album.description = "Chill album"

    favourite = Favourite.new
    favourite.user = user

    #does not save as favourite is not given an album
    assert_not favourite.save
  end
end
