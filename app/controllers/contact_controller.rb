class ContactController < ApplicationController
  # def show
  #   # id = params[:id]
  #   # puts "aSSDA: #{current_account}"
  #   @contacts = Contact.of_account(current_account).all.order(:name)
  #   # render "contact_list"
  # end

  def create
    account_id = current_account.id
    new_contact = Contact.new(
      account_id: account_id,
      name: params[:contact_name],
      phone_number: params[:country_code] + params[:phone_number],
    )
    new_contact.save
    redirect_to dashboard_url
  end

  def update
    id = params[:id]
    @contact = Contact.of_account(current_account).find(id)
    if params[:name] && params[:phone_number]
      contact.name = params[:name]
      contact.phone_number = params[:phone_number]
    elsif params[:name]
      contact.name = params[:name]
    elsif params[:phone_number]
      contact.phone_number = params[:phone_number]
    end
    contact.save
    redirect_to dashboard_url
  end

  def destroy
    id = params[:id]
    @contact = Contact.of_account(current_account).find(id)
    @contact.destroy
    redirect_to dashboard_url
  end
end
