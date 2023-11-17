# frozen_string_literal: true

class UserToken < ApplicationRecord
  has_one :user, dependent: :destroy
end
