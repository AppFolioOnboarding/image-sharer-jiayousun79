require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def test_home
    get root_path
    assert_select 'h1', 'Hello'
  end
end
