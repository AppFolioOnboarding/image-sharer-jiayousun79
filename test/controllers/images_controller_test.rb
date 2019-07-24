require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_select 'form[action="/images"]'
    assert_select 'input[name="image[url]"]'
    assert_select 'input[type="submit"]'
  end

  def test_create
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: { url: 'my_url.com' } }
    end

    assert_redirected_to new_image_path
  end
end
