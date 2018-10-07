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


    def destroy
        # @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to '/posts'
    end

    private
    def comment_params    
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
