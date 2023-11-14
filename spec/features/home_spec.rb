# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  describe 'Start page' do
    before { visit root_path }

    it { expect(page).to have_xpath "//p[contains(text(),'Create or sign in an account')]" }
  end
end
