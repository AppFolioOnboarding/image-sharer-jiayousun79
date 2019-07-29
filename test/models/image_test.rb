require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image_validation__valid
    image = Image.new(url: 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg')
    assert_predicate image, :valid?
  end

  def test_image_validation__invalid
    image = Image.new(url: 'random')
    assert_not_predicate image, :valid?
  end
end
