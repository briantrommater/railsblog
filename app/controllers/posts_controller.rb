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
        @user = User.find(session[:user_id])
    end

    #PUT /posts/:id
    def update
        post = Post.find(params[:id])
        post.update(post_params)
        flash[:notice] = "Updated post."
        redirect_to post
    end

    #POST /posts
    def create
        post = Post.create(post_params)
        post.user_id = session[:user_id]
        if post.save
            flash[:success] = 'created post'
            redirect_to post
        else
            flash[:error] = 'not logged in'
            redirect_to '/'
        # if session[:user_id] == nil
        #     flash[:notice] = "you are not logged in"
        # else
        #     flash[:notice] = "Created post."
        #     redirect_to post
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
