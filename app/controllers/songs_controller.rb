require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs= Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  post '/songs' do
    song = Song.create(name: params[:song_name], genre_ids: params[:genres])
    song.artist = Artist.find_or_create_by(name: params[:artist_name])

    if !!song.save
      flash[:message] = "Successfully created song."
    else
      flash[:message] = "Song could not be created. Please try again."
    end

    redirect to "songs/#{song.slug}"
  end

  get "/songs/:slug/edit" do
    @song=Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    @song.update(name: params[:song_name],genre_ids: params[:genres])
    @song.artist.update(name: params[:artist_name])
    flash[:message] = "Successfully updated song."
    redirect to "songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end
end
