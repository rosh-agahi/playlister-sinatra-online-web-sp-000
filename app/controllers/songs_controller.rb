class SongsController < ApplicationController
  
  get '/songs' do 
    erb :'songs/index'
  end 
    
  get '/songs/new' do
    erb :'/songs/new'
  end
  
  get '/songs/:slug' do 
    song_find_by_slug
    erb :'songs/show'
  end 
  
  post '/songs' do
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    redirect("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    song_find_by_slug
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    song_find_by_slug
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    redirect("/songs/#{@song.slug}")
  end
  
  def song_find_by_slug
    @song = Song.find_by_slug(params[:slug])
  end 
  
end