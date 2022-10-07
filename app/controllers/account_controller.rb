class AccountController < ApplicationController
  def index
    @accounts = Account.all

  def create
    new_account = Account.new(
      account_sid: params[:account_sid],
      auth_token: params[:auth_token],
      phone_number: params[:phone_number],
      account_name: params[:account_name]
    )
    new_account.save
end
