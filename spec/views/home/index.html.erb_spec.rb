# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  describe 'Home route path', type: :routing do
    before { render template: 'home/index' }

    it 'include message to user' do
      expect(rendered).to include('p', 'Create or sign in an account')
    end
  end
end
