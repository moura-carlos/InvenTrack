class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # if there is already a session[:user_id] it means the user creating this account is admin and whe dont want to log them out
      session[:user_id] = @user.id unless session[:user_id]
      redirect_to @user, status: :see_other, notice: 'Account successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, status: :see_other, notice: 'Account successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      # log out user
      session[:user_id] = nil if current_user?(@user)
      redirect_to users_url, status: :see_other, notice: 'Account successfully deleted!'
    else
      render :show, notice: 'Something went wrong! Please, try again.'
    end
  end

  private

  def user_params
    if current_user.is_admin?
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    else
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def require_correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url, notice: 'You are not authorized to do that!' unless current_user?(@user) || current_user.is_admin?
  end
end
