# encoding: UTF-8


#匯入模組
require 'sinatra/base'


class Main < Sinatra::Base  
  #進入點
  get '/' do   
    erb :Main
  end
  
  
  #開始直播
  get '/facebook_live' do
  	@stream_url=params[:stream_url]
	erb :facebook_live
  end


  post '/begin_live' do
  	OS=params[:OSName]
  	stream_url=params[:stream_url]
  	p OS
  	p stream_url

	if OS=='OS X'
		result=`ffmpeg -f avfoundation -i "Capture screen 0:Built-in Input" -f flv "#{stream_url}"`
	elsif OS=='UNIX' || OS=='LINUX'
		result=`ffmpeg -f x11grab -thread_queue_size 100 -r 10 -video_size 1024x768 -i :0 -f alsa -thread_queue_size 500 -ar 44100 -ac 1 -i default -f flv -c:v h264 -c:a aac "#{stream_url}"`
	end


	redirect '/begin_live'
  end
  
  
  
  #run sinatra server when this site is unstart
  run! if app_file == $0
end