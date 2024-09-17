require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'valid signup information' do
    get signup_path

    signup_params = {
      user: {
        name: 'Example User',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }

    assert_difference 'User.count', 1 do
      post users_path, params: signup_params
    end

    follow_redirect!
    assert_template 'users/show'
  end
end
