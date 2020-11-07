class FavouritesController < ApplicationController
    def index
      favourites = Favourite.find_by(user: current_user)
      @album = favourites.albums.all


    end

    def destroy 
        @favourite.destroy
        respond_to do |format|
          format.html { redirect_to albums_url, notice: 'Album has been removed from favourites.' }
          format.json { head :no_content }
        end
    end

    def create 
        @favourite = Favourite.new(user: current_user, album: @album)
    
        if @favourite.save
          format.html { redirect_to favourites_url, notice: 'Album has been favourited' }
          format.json { render :index, status: :created, location: @album }
        else
          format.html { redirect_to favourites_url }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end


end
