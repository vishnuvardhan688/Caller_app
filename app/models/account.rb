class Account < ApplicationRecord
  has_many :user
  has_many :call
  has_many :contact
end
