require 'test_helper'

class FavouritesControllerTest < ActionDispatch::IntegrationTest
  # tests below check whether album is favourited correctly for a given user
  setup do
    @song = songs(:one)
    @album = albums(:one)
    @albumToAdd = albums(:two)
  end

  test "should get index" do
    #needs authentication to access index favourites route, so statement below logs user into an account
    #user data from fixtures but not included in setup above as password data needs to collected before its been hashed
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get favourites_url
    assert_response :success
    # TESTING THE VIEWS
    # the favourite created in the fixtures for this user is @album, so checking against @album
    assert_select ".favouriteName", @album.name
    assert_select ".favouriteDescription", @album.description

  end

  test "should favourite album" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference("Favourite.count", 1) do
      post favourites_path(:album_id => @albumToAdd.id)
    end

    assert_equal 'Album has been favourited', flash[:notice]
    assert_redirected_to favourites_url

  end

  test "should not favourite existing favourite album" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference("Favourite.count", 1) do
      # line below favourite the album
      post favourites_path(:album_id => @albumToAdd.id)
      # trying to favourite the existing album again should not favourited but redirected instead
      post favourites_path(:album_id => @albumToAdd.id)
    end

    assert_equal 'The album has already been favourited', flash[:notice]
    assert_redirected_to favourites_url

  end

  test "should remove favourite album" do
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference("Favourite.count", -1) do
      delete favourite_url(@album.id)
    end

    assert_equal 'Album has been removed from favourites.', flash[:notice]
    assert_redirected_to favourites_url
  end

  #============================================================================
  #tests for not logged in user

  test "should not get index" do
    get favourites_url
    assert_response :redirect

  end

  test "should not favourite album" do
    assert_no_difference("Favourite.count") do
      post favourites_path(:album_id => @albumToAdd.id)
    end

  end

  test "should not remove favourite album" do
    assert_no_difference("Favourite.count") do
      delete favourite_url(@album.id)
    end
    
  end

  #==================================================================================================================================
  #these additional tests below makes sure that another logged in user cannot delete a favourite album NOT belonging to them

  test "should not remove favourite album for different user" do
    post login_url, params: { session: {username: 'SomeOtherUser', password: 'SomeOtherUser123'}}

    assert_raises(NoMethodError) do
      assert_no_difference("Favourite.count") do
        delete favourite_url(@album.id)
      end
    end
  end


end











