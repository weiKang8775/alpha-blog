class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end
  
  def update
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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog! You have successfully signed up."
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles deleted"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if (current_user != @user)
      flash[:alert] = "You are not authorized to perform this action!"
      redirect_to user_path(@user)
    end
  end
end