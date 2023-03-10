class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}!"
      redirect_to session[:intended_url] || user
      session[:intended_url] = nil
    else
      flash.now[:error] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other, notice: 'You have successfully logged out!'
  end
end
