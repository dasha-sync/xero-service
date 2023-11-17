# frozen_string_literal: true

5.times do |index|
  User.find_or_create_by(email: "user_#{index}@example.com") do |user|
    user.username = Faker::Internet.username(specifier: 10)
    user.password = 'password'
    user.user_token = UserToken.create!
  end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.debug e.message
end
