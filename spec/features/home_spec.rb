# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  let(:user) { create(:user) }

  describe 'Start page' do
    describe 'when user in not authenticated' do
      before { visit root_path }

      it { expect(page).to have_xpath "//p[contains(text(),'Create or sign in an account')]" }
    end

    describe 'when user is authenticated' do
      before do
        login_as(user, scope: :user)
        visit root_path
      end

      it { expect(page).to have_xpath "//p[contains(text(),'Explore Xero accounting software')]" }
      it { expect(page).to have_xpath "//h5[contains(text(),'Click to authorize')]" }
    end
  end
end
