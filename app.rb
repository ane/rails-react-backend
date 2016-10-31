# coding: utf-8
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sequel'
require 'sqlite3'
require_relative './database.rb'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  before do
    @data = JSON.parse(request.body.read) rescue {}
  end
  
  get '/' do

  end

  get '/artists' do
    Artist.all.to_json
  end

  get '/artists/:id' do
    @a = Artist.where(:id => params[:id]).first
    if @a
      @a.to_json
    else
      404
    end
  end

  delete '/artists/:id' do
    @a = Artist[params[:id]]
    if @a
      @a.delete
      halt 204
    else
      halt 404
    end 
  end

  post '/artists' do 
    @a = Artist.new @data
    if @a.valid?
      @a.save
      halt 201, {'Location' => "/artists/#{@a.id}"}, ''
    else
      status 422
      @a.errors.to_json
    end
  end

  put '/artists/:id' do 
    @a = Artist[params[:id]]
    if @a
      @a_new = Artist.new @data
      if @a_new.valid?
        @a.update({ :name => @a_new.name, :instrument => @a_new.instrument, :arsonist => @a_new.arsonist })
        status 204
      else
        status 422
        @a.errors.to_json
      end
    else
      status 404
    end
  end
end
