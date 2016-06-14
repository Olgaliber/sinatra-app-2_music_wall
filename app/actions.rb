@valid_users = {
  olga => "juice456"
  jack => "cocochee"
  buddy => "bold-eagle"
}

before do 
  cookies[:page_views] ? cookies[:page_views] = cookies[:page_views].to_i + 1 :cookies[:page_views]
end


# Homepage (Root path)
get '/' do
   erb :index
  #erb :'messages/login'
end

get '/messages' do
	@messages = Message.all
	erb :'messages/index'
end

get '/messages/new' do
   erb :'messages/new'
end

get '/messages/:id' do
  @message = Message.find params[:id]
  erb :'messages/show'
end

get '/login' do 
  erb :'messages/login'
end

post '/login' do
  erb :'messages/new'
  if valid_users[params[:username].to_sym] == params [:password]
    cookies[:username] = [params[:username]
  else 
    #flash message here
    redirect_to "/login"
  end
end

get '/delete/:id' do
  message = Message.find params[:id]
  message.destroy
  redirect '/messages'
  # @messages = Message.all
	# erb :'messages/index'
  # erb :'messages/show'
end

post '/messages' do

	params[:updated_at] = Time.now.getutc
	params[:created_at] = Time.now.getutc

   @message = Message.new(
     title:   params[:title],
     content: params[:content],
     author:  params[:author],
     url: params[:url],
     created_at: params[:created_at],
     updated_at: params[:updated_at]
   )

   if @message.save
     redirect '/messages'
   else
     erb :'messages/new'
   end
end