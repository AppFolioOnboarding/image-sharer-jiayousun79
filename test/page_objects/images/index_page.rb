require File.expand_path(__dir__) + '/image_card.rb'

module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: 'table', item_locator: 'td', contains: PageObjects::Images::ImageCard

      def showing_image?(url, tag)
        images.any? do |img|
          expected_tag_string = img.tag_list.map(&:text).join(', ')
          img.url == url && (expected_tag_string == tag.to_s)
        end
      end

      def delete(img_url)
        image_delete = images.find { |img| img.url == img_url }
        image_delete&.deletebtn&.node&.click
        yield node.driver.browser.switch_to.alert
      end

      def clear_tag_filter!
        # TODO
      end
    end
  end
end
