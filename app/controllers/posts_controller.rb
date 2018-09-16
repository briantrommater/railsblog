class PostsController < ApplicationController
    
    #GET /posts/all
    def index
        @posts = Post.all
    end

    #GET /posts/new
    def new
        @post = Post.new
        @user = User.find(session[:user_id])
    end

    #GET /posts/:id
    def show 
    @post = Post.find(params[:id])
    end

    #GET /posts/:id/edit
    def edit
    @post = Post.find(params[:id])
    end

    #PUT /posts/:id
    def update
    post = Post.find(post_params)
    post.update(params[:post])
    flash[:notice] = "Updated post."
    redirect_to post
    end

    #POST /posts
    def create
    if session[:user_id] = nil
    redirect_to post, notice: "you are not logged in"
    else
    post = Post.create(post_params)
    flash[:notice] = "Created post."
    redirect_to post
    end
    end

    #DELETE /posts/:id
    def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Destroyed post."
    redirect_to posts_path
    end

    private
    def post_params    
      params.require(:post).permit(:user_id, :body)
    end


end
