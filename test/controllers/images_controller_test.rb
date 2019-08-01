require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_select 'form[action="/images"]'
    assert_select 'input[name="image[url]"]'
    assert_select 'input[name="image[tag_list]"]'
    assert_select 'input[type="submit"]'
    assert_select 'a[href=?]', images_path
  end

  def test_root
    get root_path
    assert_response :success
  end

  def test_create__valid_notag
    assert_difference 'Image.count', 1 do
      post images_path, params: {
        image: {
          url: 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg'
        }
      }
    end

    assert_redirected_to image_path(Image.last)
    follow_redirect!
    assert_select '.alert-success', text: 'Post successfully created', count: 1
  end

  def test_create__valid_withtag
    tags_string = 'test, show'

    tags_string_arr = %w[test show]

    assert_difference 'Image.count', 1 do
      post images_path, params: {
        image: {
          url: 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg',
          tag_list: tags_string
        }
      }
    end

    assert_redirected_to image_path(Image.last)
    follow_redirect!
    assert_select '.alert-success', text: 'Post successfully created', count: 1
    assert_equal 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg',
                 Image.last.url
    assert_equal tags_string_arr, Image.last.tag_list
  end

  def test_create__invalid
    tags_string = 'test,show'

    assert_difference 'Image.count', 0 do
      post images_path, params: { image: { url: 'random', tag_list: tags_string } }
    end
    assert_response :unprocessable_entity
    assert_select 'form[action="/images"]'
    assert_select 'input[name="image[url]"][value="random"]'
    assert_select "input[name='image[tag_list]'][value='#{tags_string}']"
    assert_select '.url .error'
    assert_select 'input[type="submit"]'
  end

  def test_show
    image = Image.create!(url: 'https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg')

    get image_path(image)

    assert_select "img[src='#{image.url}']"

    assert_select '.notice', count: 0

    assert_select 'a[href=?]', images_path
  end

  def test_show__image_does_not_exist
    get image_path(-1)

    assert_redirected_to root_path
  end

  def test_index__display_image_nonempty
    image = Image.create!(url: 'https://uploads-ssl.webflow.com/54fcefe421c2e6761cc51a4e/58a4e00e0732e3562fac11bd_homepage_logo.png')

    get images_path

    assert_select "img[src='#{image.url}']"
  end

  def test_index__display_image_empty
    get images_path

    assert_response :ok

    assert_select 'img', count: 0
  end

  def test_index__image_order
    ordered_images = [Image.create!(url: 'https://pbs.twimg.com/profile_images/971359833826918400/G1aAQGO-_400x400.jpg',
                                    created_at: 7.minutes.ago(Time.now)),
                      Image.create!(url: 'http://www.clker.com/cliparts/V/H/K/p/p/u/number-2-black-hi.png',
                                    created_at: 8.minutes.ago(Time.now)),
                      Image.create!(url: 'https://web.uri.edu/assessment/files/3-countdown.jpg',
                                    created_at: 9.minutes.ago(Time.now)),
                      Image.create!(url: 'https://www.rhythmroomstudio.com/uploads/1/2/0/8/12089761/s945537655474991480_p10_i3_w1280.jpeg',
                                    created_at: 10.minutes.ago(Time.now))]

    get images_path

    assert_select 'tr' do |trs|
      trs.each_with_index do |tr, index|
        assert_select tr, "img[src='#{ordered_images[index].url}']", 1
      end
    end
  end
end
