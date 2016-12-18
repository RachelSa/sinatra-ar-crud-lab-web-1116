require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do #this path
    erb :new #goes to new post form
  end

  post '/posts' do #this posts new name and content
    @post = Post.create(name: params[:name],content: params[:content]) #and creates instance AND db row for post
    redirect to '/posts' #redirects to posts idex
  end

  get '/posts' do #this path
     @posts = Post.all #gets all posts
     erb :index #and displays via index page
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id]) #finds the post to edit
    erb :edit #and goes to edit form
  end

  get '/posts/:id/delete' do 
    @id = params[:id] #finds id of post to delete
    erb :show #and shows post with delete button
  end

  delete '/posts/:id/delete' do
    @id = params[:id].to_i #id of post to delete
    @name = Post.find(@id).name #name of post to be deleted
    Post.delete(@id) #delete post
    erb :deleted #display name of deleted post
  end

  patch '/posts/:id' do
    @id = params[:id].to_i #id of post to update
    name = params[:name] #updated params
    content = params[:content]
    post = Post.find(@id) #find post
    post.update(name: name,content: content) #update it
    erb :show #show updated post
  end

  get '/posts/:id' do 
    @id = params[:id].to_i 
    erb :show #show post by specific id
  end

end