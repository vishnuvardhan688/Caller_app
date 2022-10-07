class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def create
    user = User.find_by(username: params[:username])
    if (user && user.password == params[:password])
      session[:current_user_id] = user.id
      session[:current_account_id] = user.account_id
      redirect_to "/"
    else
      flash[:error] = "Your Login Attempt Was Invalid, Please Try Again."
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    session[:current_account_id] = nil
    $current_user = nil
    $current_account = nil
    redirect_to "/"
  end
end
