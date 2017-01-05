ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  ActiveRecord::Migration.maintain_test_schema!

  fixtures :all
  include ApplicationHelper
  include SessionsHelper
  include UsersHelper
  
  setup do
    DatabaseCleaner.strategy = :transaction
  end

  def is_logged_in?
    session[:user_id].present?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'password')
    post welcome_path, params: { session: { username: user.username, 
                                            password: password, } }
  end
end
