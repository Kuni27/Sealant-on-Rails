# frozen_string_literal: true

class AddRoleToWhitelists < ActiveRecord::Migration[7.1]
  def change
    add_column :whitelists, :role, :string
  end
end
