class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    puts "curr1: #{current_account}"
    unless current_user
      redirect_to "/"
    end
  end

  def current_user
    return $current_user if $current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      $current_user = User.find(current_user_id)
    else
      nil
    end
  end

  def current_account
    return @current_account if @current_account

    current_account_id = session[:current_account_id]
    if current_account_id
      $current_account = Account.find(current_account_id)
    else
      nil
    end
  end
end
