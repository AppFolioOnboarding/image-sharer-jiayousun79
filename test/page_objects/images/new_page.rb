module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :url
        element :tag_list
        element :error_message, locator: '.error'
      end

      def create_image!(url: nil, tags: nil)
        self.url.set(url) if url.present?
        tag_list.set(tags) if tags.present?
        node.click_button('Create Image')
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
