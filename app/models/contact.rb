class Contact < ApplicationRecord
  belongs_to :account

  def self.of_account(account)
    all.where(account_id: account.id)
  end
end
