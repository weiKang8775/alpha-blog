class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if (@user.update(user_params))
      flash[:notice] = "Your profile is updated successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.save)
      flash[:notice] = "Welcome to Alpha Blog! You have successfully signed up."
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end