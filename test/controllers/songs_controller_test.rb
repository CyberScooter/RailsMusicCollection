require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
  end

  test "should get index" do
    get songs_url
    assert_response :success
  end

  test "should get new" do
    get new_song_url
    assert_response :success
  end

  test "should create song" do
    assert_difference('Song.count') do
      post songs_url, params: { song: { artist: @song.artist, name: @song.name, year: @song.year } }
    end

    assert_redirected_to song_url(Song.last)
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete song_url(@song)
    end

    assert_redirected_to songs_url
  end
end
