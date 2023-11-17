# frozen_string_literal: true

class CreateUserTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tokens do |t|
      t.json :token_set
      t.string :active_tenant_id

      t.timestamps
    end
  end
end
