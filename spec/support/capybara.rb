require 'capybara/rspec'
require 'capybara/rails'
require 'selenium-webdriver'

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
  
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new app,
      browser: :chrome,
      options: Selenium::WebDriver::Chrome::Options.new(args: %w[disable-popup-blocking headless disable-gpu window-size=1920,1080])
  end

  Capybara.javascript_driver = :chrome
end
