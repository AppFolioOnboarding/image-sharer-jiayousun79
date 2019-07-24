require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_select 'form[action="/images"]'
    assert_select 'input[name="image[url]"]'
    assert_select 'input[type="submit"]'
  end

  def test_create__valid
    assert_difference 'Image.count', 1 do
      post images_path, params: {
        image: {
          url: 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg'
        }
      }
    end

    assert_redirected_to new_image_path
  end

  def test_create__invalid
    assert_difference 'Image.count', 0 do
      post images_path, params: { image: { url: 'random' } }
    end
    assert_response :unprocessable_entity
    assert_select 'form[action="/images"]'
    assert_select 'input[name="image[url]"][value="random"]'
    assert_select '.url .error'
    assert_select 'input[type="submit"]'
  end
end
