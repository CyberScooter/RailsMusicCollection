class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  #blocks access to albums manipulatin if not logged in
  before_action :authorized, only: [:index, :edit, :new, :create, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    if(current_user) 
      @albums = current_user.albums.all
    end
    
  end

  def edit
  end

  # GET /albums/new
  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.create(album_params)


    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_url, notice: 'Album was successfully created.' }
        format.json { render :index, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #checks if user updating the album owns the album so not any registered user can update it
    if(current_user.albums.find(@album.id))
      respond_to do |format|
        if @album.update(album_params)
          format.html { redirect_to albums_url, notice: 'Album was successfully updated.' }
          format.json { render :index, status: :ok, location: @album }
        else
          format.html { render :edit }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    #checks if user deleting the album owns the album so not any registered user can delete it
    if(current_user.albums.find(@album.id))
      @favourite = Favourite.find_by(album_id: @album.id)

      #deletes songs from songs table for the given album id
      @song = Song.joins(:albums).select('songs.id').where('albums.id' => @album.id)
      @song.destroy_all

      #deletes album reference in favourites before deleting the album 
      if @favourite
        @favourite.destroy
      end
      
      #deletes album from the table
      if @album.destroy 
        redirect_to albums_url, notice: 'Album was successfully destroyed.' 
      else 
        redirect_to albums_url, notice: @album.errors
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :description)
    end
end
