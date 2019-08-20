require 'test_helper'
require 'json'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  def test_create__with_text
    post 'http://localhost:3000/api/feedbacks', as: :json, params: { feedbackName: 'Foo', feedbackText: 'Bar' }
    assert_response :success
    assert_equal 'Foo', JSON.parse(response.body)['feedbackName']
    assert_equal 'Bar', JSON.parse(response.body)['feedbackText']
  end

  def test_create__no_text
    post 'http://localhost:3000/api/feedbacks', as: :json, params: { feedbackName: 'Foo', feedbackText: '' }
    assert_response :bad_request
  end
end
