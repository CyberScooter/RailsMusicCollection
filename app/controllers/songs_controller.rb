class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  #blocks access to ALL songs routes if not logged by using the helper method in application controller created
  #redirects to root url if not logged in
  before_action :authorized, only: [:index, :edit, :new, :create, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    #album id going to be useful for selecting songs
    album = Album.find_by(id: params[:album_id])

    @songs = album.songs.all
  end

  # GET /songs/new
  def new
    album = Album.find_by(id: params[:album_id])
    @song = album.songs.new
  end

  # POST /songs
  # POST /songs.json
  def create
    #checks if logged in user owns the album, if so songs can be added. to stop random logged in users adding songs
    if(current_user.albums.find_by(id: params[:album_id]))
      album = Album.find_by(id: params[:album_id])

      @song = album.songs.create(song_params)

      respond_to do |format|
        if @song.save
          format.html { redirect_to songs_url, notice: I18n.t('songs.created') }
          format.json { render :show, status: :created, location: @song }
        else
          format.html { render :new }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_song_url, notice: I18n.t('songs.invalid-operation')
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    #if song belongs to current user logged in
    if(current_user.albums.find(@song.albums.ids))
      @song.destroy
      respond_to do |format|
        format.html { redirect_to albums_url, notice: I18n.t('songs.deleted') }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:name, :artist, :year)
    end


end
