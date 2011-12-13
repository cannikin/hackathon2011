require 'sinatra'
require 'httparty'
require 'haml'
require 'sass'

configure do
  set :api_key, '3qqfpazw46um75vgaqmg9ck6'
  set :haml, :format => :html5, :attr_wrapper => '"'
end


get '/' do
  haml :index
end


# get popular events for a sport
get '/search' do
  headers 'Content-Type' => 'application/json'
  HTTParty.get("http://api.amp.active.com/search/popular?channel=#{params[:channel]}&zip=#{params[:zip]}&days=30&num=#{params[:num] || 25}&api_key=#{settings.api_key}").to_json
end


# get details for a given asset_id
get '/detail' do
  headers 'Content-Type' => 'application/json'
  HTTParty.get("http://api.amp.active.com/search?m=meta:assetId=#{params[:asset_id].gsub('-','%252d')}&api_key=#{settings.  api_key}&v=json").to_s
  # valid asset_id: 865bcc67%252db151%252d4aa1%252db525%252d6d641f032e81
end


# stylesheet
get '/shared.css' do
  sass :shared
end
