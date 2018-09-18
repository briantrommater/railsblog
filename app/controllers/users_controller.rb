class UsersController < ApplicationController
    
    def index
        @users = User.all
      end
    
    #GET /users/new
    def new
      @user = User.new
    end
  
    #GET /users/:id
    def show 
      @user = User.find(params[:id])
    end
  
    #GET /users/:id/edit
    def edit
      @user = User.find(params[:id])
    end
  
    #PUT /users/:id
    def update
      user = User.find(params[:id])
      user.update(user_params)
      flash[:notice] = "Updated user."
      redirect_to user
    end
  
    #POST /users
    def create
      user = User.new(user_params)
      if user.save
        flash[:notice] = "Created user."
        redirect_to user
      else
        flash[:notice] = "There was an error: "
        flash[:notice] += user.errors.full_messages.join(', ')
        redirect_to new_user_path
      end
    end
  
    #DELETE /users/:id
    def destroy
      @user = User.find(params[:id])
      @user.posts.each do |post|
        post.comments.destroy_all
      end
      @user.comments.destroy_all
      @user.posts.destroy_all
      if @user.destroy
      flash[:success] = "Destroyed user."
      else
      flash[:error] = "problem destroying user"
      end
      redirect_to users_path  
    end

    private
    def user_params    
      params.require(:user).permit(:name, :email, :password)
    end
    
end
