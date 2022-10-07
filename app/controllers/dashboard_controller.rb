class DashboardController < ApplicationController
  def index
    @tickets = Ticket.all
    @contacts = Contact.of_account(current_account).all.order(:name)
  end
end
