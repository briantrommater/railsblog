class CommentsController < ApplicationController
    #GET /comments/all
    def index
        @comments = Comment.all
    end

    #GET /comments/new
    def new
        @comment = Comment.new
    end

    #GET /comments/:id
    def show 
        @comment = Comment.find(params[:id])
    end

    #GET /comments/:id/edit
    def edit
        @comment = Comment.find(params[:id])
    end

    #PUT /comments/:id
    def update
        comment = Comment.find(comment_params)
        comment.update(params[:comment])
        flash[:notice] = "Updated comment."
        redirect_to comment
    end

    #POST /comments
    def create
        comment = Comment.create(comment_params)
        flash[:notice] = "Created comment."
        redirect_to comment
    end

    #DELETE /comments/:id
    def destroy
        comment.find(params[:id]).destroy
        flash[:notice] = "Destroyed comment."
        redirect_to comments_path
    end

    private
    def comment_params    
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
