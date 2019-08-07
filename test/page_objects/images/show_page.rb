module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def image_present?(url)
        node.find("img[src=\"#{url}\"]").present?
      end

      def tags
        node.all('li').map(&:text)
      end

      def go_back_to_index!
        node.click_on('Homepage')
        window.change_to(IndexPage)
      end
    end
  end
end
