require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

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
  end

  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: 'Example User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    log_in_as(user)
    assert_not is_logged_in?

    get edit_account_activation_path('invalid token', email: user.email)
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert_predicate user.reload, :activated?

    follow_redirect!
    # assert_template 'users/show'
    # assert_predicate self, :is_logged_in?
  end
end
