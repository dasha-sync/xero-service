# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserToken, type: :model do
  subject(:user_token) { build(:user_token) }

  context 'when factory is valid' do
    it { expect(build(:user_token)).to be_valid }
  end

  describe 'associations' do
    it { expect(user_token).to have_one(:user) }
  end
end
