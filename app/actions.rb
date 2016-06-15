
before do 
  cookies[:page_views] ? cookies[:page_views] = cookies[:page_views].to_i + 1 :cookies[:page_views]
end


# Homepage (Root path)
get '/' do
   erb :index
  #erb :'messages/login'
end

get '/messages' do
	@messages = Message.order(upvote: :desc)
	erb :'messages/index'
end

get '/messages/new' do
   erb :'messages/new'
end

get '/signup' do 
  erb :'messages/signup'
end

get '/messages/:id' do
  @message = Message.find params[:id]
  if @message.upvote == nil
    @message.upvote = 0
  end 
  erb :'messages/show'
end

get '/upvote/:id' do
  @message = Message.find params[:id]
  # message.destroy
  # redirect '/messages'
  if @message.upvote == nil
    @message.upvote = 0
  end 

  @message.upvote += 1
  @message.save!

  redirect '/messages'
end


post '/login' do
  erb :'messages/new'
  user = User.find_by(email: params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect '/messages'
  else 
    #flash message here
    redirect '/login'
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
     updated_at: params[:updated_at],
     upvote: 0
   )

   if @message.save
     redirect '/messages'
   else
     erb :'messages/new'
   end
end