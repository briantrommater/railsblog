class CommentsController < ApplicationController
    #GET /comments/all
    def index
        @comments = Comment.all
    end

    #GET /comments/new
    def new
        @comment = Comment.new
        @comment = Comment.new(post_id: params[:post_id])
        @post = Post.find(params[:post_id])
    end

    #POST /comments
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = session[:user_id]
        @post = params[:id]
        if @comment.save
          flash[:notice] = "comment created."
          redirect_to "/posts/#{params[:post_id]}"
        else
          flash[:error] = "Error creating comment."
          render '/'
        end
    end
    
    #GET /posts/:id/edit
    def edit
        @comment = Comment.find(params[:id])
        @post = Post.find(params[:post_id])
    end

    #PUT /posts/:id
    def update
        comment = Comment.find(params[:id])
        comment.update(comment_params)
        flash[:notice] = "Updated post."
        redirect_to "/posts/#{params[:post_id]}"
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to '/posts'
    end

    private
    def comment_params    
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
