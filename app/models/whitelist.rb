# frozen_string_literal: true

# app/models/whitelist.rb
class Whitelist < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  def admin?
    role == 'Admin'
  end

  has_many :users
end
