require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

<<<<<<< chapter5-filling-in-layout
  test 'should get home' do
      get root_path
      assert_response :success
      assert_select 'title', @base_title
    end
=======
  test 'should get root' do
    get root_url
    assert_response :success
    assert_select 'title', "#{@base_title}"
  end

  test 'should get home' do
    get static_pages_home_url
    assert_response :success
    assert_select 'title', "#{@base_title}"
  end
>>>>>>> master

  test 'should get help' do
    base_title = 'Ruby on Rails Tutorial Sample App'
    get help_path
    assert_response :success
    assert_select 'title', "Help | #{base_title}"
  end

  test 'should get about' do
    base_title = 'Ruby on Rails Tutorial Sample App'
    get about_path
    assert_response :success
    assert_select 'title', "About | #{base_title}"
  end

  test 'should get contact' do
    base_title = 'Ruby on Rails Tutorial Sample App'
    get contact_path
    assert_response :success
    assert_select 'title', "Contact | #{base_title}"
  end
end
