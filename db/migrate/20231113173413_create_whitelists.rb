# frozen_string_literal: true

class CreateWhitelists < ActiveRecord::Migration[7.1]
  def change
    create_table :whitelists do |t|
      t.string :email

      t.timestamps
    end
  end
end
