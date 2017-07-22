# encoding: UTF-8


#匯入模組
require 'sinatra/base'
require 'rest-graph'
require 'rest-client'
require 'koala'


class Main < Sinatra::Base  
  #進入點
  get '/' do   
    erb :Main
  end
  
  
  #開始直播
  post '/facebook_live' do
  	#自動取得FB權仗記錄
  	app_id='1310588732364045'
	app_secret='9cd6313c90193d3c15b3c1996b1227c8'
	callback_url='https://rov-fblive.herokuapp.com/'
	@oauth = Koala::Facebook::OAuth.new(app_id, app_secret, callback_url)
	access_token=@oauth.get_app_access_token


=begin
	#取得FB權仗及OS的記錄
	access_token=params[:access_token]
    OS=params[:OS]


    #取得FB權仗資料
    access_token='EAAbUKoyDdIEBAGNYf0l2iW0ZC2dq3GJdXbe59CwvExc9gQJu0TE2u4MRjZAddFpUVITAR8np6wcEzTscKv0MtXm63omx4Y4k04QjY4gR8GG20waPSDpMstq4ATYnQ5SLy9aak9PbpKSlkZAdcARVczPkxV6WUQZCRiCbxIe1SJn1ZAjdvF0FskflhahhJK2YZD'
    rg = RestGraph.new(:access_token => access_token)
	

	if rg!=nil
		#取得FB使用者資料
		myself=rg.get('me')
		if myself!={}
			id=myself['id']
			name=myself['name']


			#取得FB直播資料
			live_videos=rg.post("#{id}/live_videos")
			if live_videos!={}
				

				#建立直播
				stream_url=live_videos['data'][0]['stream_url']
				if stream_url!=nil
					if OS=='OS X'
						#result=`ffmpeg -f avfoundation -i "Capture screen 0:Built-in Input" -f flv "#{stream_url}"`
					elsif OS=='UNIX' || OS=='LINUX'
						#result=`ffmpeg -f x11grab -thread_queue_size 100 -r 10 -video_size 1024x768 -i :0 -f alsa -thread_queue_size 500 -ar 44100 -ac 1 -i default -f flv -c:v h264 -c:a aac "#{stream_url}"`
					end
				end
			end
		end
	end
=end

	#redirect '/'

	"#{app_id} #{app_secret} #{access_token} begin streaming."
  end
  
  
  
  #run sinatra server when this site is unstart
  run! if app_file == $0
end