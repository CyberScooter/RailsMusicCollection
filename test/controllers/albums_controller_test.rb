require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album = albums(:one)
  end

  test "should get index" do
    #needs authentication to access index albums route, so statement below logs user into an account
    #user data from fixtures but not included in setup above as password data needs to collected before its been hashed
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get albums_url
    assert_response :success
    # TESTING THE VIEWS
    assert_select '.albumName', @album.name
  end

  test "should get new" do
    #needs authentication to access new albums route, so statement below logs user into an account
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get new_album_url
    assert_response :success
  end

  test "should create album" do
    #needs authentication to create a new album, so statement below logs user into an account
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference('Album.count', 1) do
      post albums_url, params: { album: { description: @album.description, name: @album.name } }
    end

    assert_equal "Album was successfully created.", flash[:notice]
    assert_redirected_to albums_path
    #allows assert_select to extract from redirect
    follow_redirect!  
    # TESTING THE VIEWS
    #if album name h3 tag matches the album name added
    assert_select '.albumName', @album.name
    #if album description h4 tag matches the album description added
    assert_select ".albumDescription", @album.description

  end

  test "should show album" do
    get album_url(@album)
    assert_response :success
  end

  test "should get edit" do
    #needs authentication to edit an album, so statement below logs user into an account
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    get edit_album_url(@album)
    assert_response :success
  end

  test "should update album" do
    #needs authentication to update an album, so statement below logs user into an account
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    patch album_url(@album), params: { album: { description: @album.description, name: @album.name } }

    assert_equal "Album was successfully updated.", flash[:notice]
    assert_redirected_to albums_url
    #allows assert_select to extract from redirect
    follow_redirect!  
    # TESTING THE VIEWS
    #if album name h3 tag matches the album name added
    assert_select ".albumName", @album.name
    #if album description h4 tag matches the album description added
    assert_select ".albumDescription", @album.description

  end

  test "should destroy album" do
    #needs authentication to update an album, so statement below logs user into an account
    post login_url, params: { session: {username: 'AnExistingUser', password: 'AnExistingUser123'}}

    assert_difference('Album.count', -1) do
      delete album_url(@album)
    end

    assert_equal "Album was successfully destroyed.", flash[:notice]
    assert_redirected_to albums_url
  end
  

  #==============================================================================================================================================
  #additional tests below make sure that if the user is not logged in/no active user session they cannot edit, update or destroy albums
  test "should not get edit" do
    get edit_album_url(@album)
    assert_redirected_to root_url

  end

  test "should not update album" do
    patch album_url(@album), params: { album: { description: @album.description, name: @album.name } }

    assert_redirected_to root_url
  end

  test "should not destroy album" do
    assert_difference('Album.count', 0) do
      delete album_url(@album)
    end

    assert_redirected_to root_url
  end


  #==================================================================================================================================
  #these additional tests below makes sure that another logged in user cannot delete or edit an album NOT belonging to them
  
  test "should not update album for different user" do
    #logging into a user that has access to none of the dummy data albums in the database
    post login_url, params: { session: {username: 'SomeOtherUser', password: 'SomeOtherUser123'}}

    assert_raises(ActiveRecord::RecordNotFound) do

      patch album_url(@album), params: { album: { description: @album.description, name: @album.name } }
  
      exception = assert_raises(ActiveRecord::RecordNotFound) { whatever.merge }
      #could not find an album belonging to that user was the error
      assert_equal( "Couldn't find Album with 'id'=1 [WHERE \"albums_users\".\"user_id\" = ?]", exception.message )
    end

  end

  test "should not destroy album for different user" do
    #user below has access to none of the dummy data albums in the database
    post login_url, params: { session: {username: 'SomeOtherUser', password: 'SomeOtherUser123'}}
    assert_raises(ActiveRecord::RecordNotFound) do

      assert_difference('Album.count',0) do
        delete album_url(@album)
      end
  
      assert_equal "Album was successfully destroyed.", flash[:notice]
      assert_redirected_to albums_url
  
      exception = assert_raises(ActiveRecord::RecordNotFound) { whatever.merge }
      #could not find an album belonging to that user was the error
      assert_equal( "Couldn't find Album with 'id'=1 [WHERE \"albums_users\".\"user_id\" = ?]", exception.message )

    end
    
  end
end
