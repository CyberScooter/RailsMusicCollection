class FavouritesController < ApplicationController
  #blocks access to favourites routes if not logged in
  before_action :authorized, only: [:create, :index, :destroy]

  def index
    #selects all albums that the current user logged in has favourited
    @album = Album.where(:id => Favourite.select(:album_id).where(:user_id => current_user.id))
  end

  def destroy 
    # favourite album belonging to user logged in is checked in this below, using current_user session data
    @favourite = Favourite.find_by(album_id: params[:id], user_id: current_user.id)

    if @favourite.destroy
      redirect_to favourites_url, notice: 'Album has been removed from favourites.'
    else 
      redirect_to favourites_url, notice: 'Could not remove album'
    end
  end

  def create 
      #finds album id passed from album controller 
      album = Album.find(params[:album_id])
      #creates a link between the user logged in and the album inside of the favourites table using foreign keys
      @favourite = Favourite.create(user: current_user, album: album)
  
      if @favourite.save
        redirect_to favourites_url, notice: 'Album has been favorited' 
      else
        redirect_to favourites_urlm notice: 'Error has occurred' 
      end
  end


end
