class FavouritesController < ApplicationController
    #blocks access to albums manipulatin if not logged in
    before_action :authorized, only: [:create, :index, :destroy]
    def index
      #selects all albums that the current user logged in has favourited
      @album = Album.where(:id => Favourite.select(:album_id).where(:user_id => current_user.id))
    end

    def destroy 
        @favourite = Favourite.find_by(album_id: params[:id])

        @favourite.destroy
        respond_to do |format|
          format.html { redirect_to favourites_url, notice: 'Album has been removed from favourites.' }
          format.json { head :no_content }
        end
    end

    def create 
        album = Album.find(params[:album_id])
        @favourite = Favourite.create(user: current_user, album: album)
    
        if @favourite.save
          respond_to do |format|
          format.html { redirect_to favourites_url, notice: 'Album has been favorited' }
          format.json { render :index, status: :created, location: @album }
          end
        else
          respond_to do |format|
          format.html { redirect_to favourites_url }
          format.json { render json: @album.errors, status: :unprocessable_entity }
          end
        end
      end


end
