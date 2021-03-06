require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'add an image' do
    new_image_page = PageObjects::Images::NewPage.visit

    tags = %w[foo bar]
    new_image_page = new_image_page.create_image!(
      url: 'invalid',
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)
    assert_equal 'is not a valid URL', new_image_page.error_message.text

    image_url = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page.url.set(image_url)

    image_show_page = new_image_page.create_image!
    assert_equal 'Post successfully created', image_show_page.flash_message(:success)

    assert image_show_page.image_present?(image_url)
    assert_equal tags, image_show_page.tags

    images_index_page = image_show_page.go_back_to_index!
    assert images_index_page.showing_image?(image_url, tags.join(', '))
  end

  test 'delete an image' do
    cute_puppy_url = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    ugly_cat_url = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    images_array = Image.create!([
      { url: cute_puppy_url, tag_list: 'puppy, cute' },
      { url: ugly_cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, images_index_page.images.count
    assert images_index_page.showing_image?(ugly_cat_url, images_array[1].tag_list)
    assert images_index_page.showing_image?(cute_puppy_url, images_array[0].tag_list)

    images_index_page.delete(ugly_cat_url) do |confirm_dialog|
      assert_equal 'Are you sure?', confirm_dialog.text
      confirm_dialog.dismiss
    end

    images_index_page.delete(ugly_cat_url, &:accept)

    assert_equal 'Post successfully deleted', images_index_page.flash_message(:success)

    assert_equal 1, images_index_page.images.count
    assert_not images_index_page.showing_image?(ugly_cat_url, images_array[1].tag_list)
    assert images_index_page.showing_image?(cute_puppy_url, images_array[0].tag_list)
  end

  test 'view images associated with a tag' do
    puppy_url1 = 'http://www.pawderosa.com/images/puppies.jpg'
    puppy_url2 = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    cat_url = 'http://www.ugly-cat.com/ugly-cats/uglycat041.jpg'
    images_array = Image.create!([
      { url: puppy_url1, tag_list: 'superman, cute' },
      { url: puppy_url2, tag_list: 'cute, puppy' },
      { url: cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    [puppy_url1, puppy_url2, cat_url].each_with_index do |url, idx|
      assert images_index_page.showing_image?(url, images_array[idx].tag_list)
    end

    images_index_page = images_index_page.images[1].click_tag!('cute')

    assert_equal 2, images_index_page.images.count
    assert_not images_index_page.showing_image?(cat_url, images_array[2].tag_list)

    images_index_page = images_index_page.clear_tag_filter!
    assert_equal 3, images_index_page.images.count
  end
end
