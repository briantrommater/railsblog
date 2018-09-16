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
      user = User.find(user_params)
      user.update(params[:user])
      flash[:notice] = "Updated user."
      redirect_to user
    end
  
    #POST /users
    def create
      user = User.create(user_params)
      flash[:notice] = "Created user."
      redirect_to user
    end
  
    #DELETE /users/:id
    def destroy
      User.find(params[:id]).destroy
      flash[:notice] = "Destroyed user."
      redirect_to users_path
    end

    private
    def user_params    
      params.require(:user).permit(:name, :email, :password)
    end
    
end
