module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      element :deletebtn, locator: 'a[data-method="delete"]'

      collection :tag_list, locator: 'ul', item_locator: 'li' do
        element :tag, locator: 'a'
      end

      def url
        node.find('img')[:src]
      end

      def click_tag!(tag_name)
        # TODO
      end
    end
  end
end
