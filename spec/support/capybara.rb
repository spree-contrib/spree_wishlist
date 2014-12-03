require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

module Spree
  module TestingSupport
    module CapybaraHelpers
      def sign_in_as!(user)
        visit spree.login_path
        within '#new_spree_user' do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
        end
        click_button 'Login'
      end
    end
  end
end

RSpec.configure do |config|
  config.include Spree::TestingSupport::CapybaraHelpers, type: :feature
  Capybara.javascript_driver = :poltergeist
end
