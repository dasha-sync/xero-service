# frozen_string_literal: true

class AddUserTokenToUser < ActiveRecord::Migration[7.0]
  change_table :users do |t|
    t.belongs_to :user_token, null: false, foreign_key: { on_delete: :cascade }
  end
end
