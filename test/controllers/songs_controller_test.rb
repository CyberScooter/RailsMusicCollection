require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:one)
    @album = albums(:one)
  end

  test "should get index" do
    #needs authentication to access index songs route, so statement below logs user into an account
    #user data from fixtures but not included in setup above as password data needs to collected before its been hashed
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get songs_url(@album)
    assert_response :success

    # @album only has three songs for the user: "AnExistingUser"
    # testing that only 3 tags are created for each the: songName, songArtist, songYear
    assert_select ".songName",3
    assert_select ".songArtist",3
    assert_select ".songYear",3

  end

  test "should get new" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get new_song_url(@album)
    assert_response :success
  end

  test "should create song" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference('Song.count') do
      post songs_url(@album), params: { song: { artist: "TestSongArtistToAdd", name: "TestSongNameToAdd", year: "2011-01-23" } }
    end

    assert_equal "Song was successfully created.", flash[:notice]
    assert_redirected_to songs_url(@album)
    follow_redirect!  
    # TESTING THE VIEWS
    # added a new song to the album being used so now there should be 4 displayed in total instead of 3
    assert_select ".songName",4
    assert_select ".songArtist",4
    assert_select ".songYear",4
    
  end

  test "should destroy song" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference('Song.count', -1) do
      delete song_url(@song.id, @song)
    end

    assert_equal "Song was successfully deleted.", flash[:notice]
    assert_redirected_to albums_url
  end

#===========================================================================================================
#additional tests below make sure that if the user is not logged in/no active user session they cannot create and destroy songs

  test "should not create song" do
    #no difference in the songs db tables
    assert_no_difference('Song.count') do
      post songs_url(@album), params: { song: { artist: "TestSongArtistToAdd", name: "TestSongNameToAdd", year: "2011-01-23" } }
    end

    #redirect to root url which is what the "authorized" method in application controller should do
    assert_redirected_to root_url

  end

  test "should not destroy song" do
    #no difference in the songs db tables
    assert_no_difference('Song.count') do
      delete song_url(@song.id, @song)
    end

    #redirect to root url which is what the "authorized" method in application controller should do
    assert_redirected_to root_url

  end

  #==================================================================================================================================
  #these additional tests below makes sure that another logged in user cannot delete or edit a song NOT belonging to them

  test "should not create song for different user" do
    post login_url, params: { session: {username: 'SomeOtherUser', password: 'SomeOtherUser123'}}

    assert_no_difference('Song.count') do
      post songs_url(@album), params: { song: { artist: "TestSongArtistToAdd", name: "TestSongNameToAdd", year: "2011-01-23" } }
    end

  end

  test "should not destroy song for different user" do
    post login_url, params: { session: {username: 'SomeOtherUser', password: 'SomeOtherUser123'}}
    assert_raises(ActiveRecord::RecordNotFound) do

      assert_no_difference('Song.count') do
        delete song_url(@song.id, @song)
      end
    end

  end


end

