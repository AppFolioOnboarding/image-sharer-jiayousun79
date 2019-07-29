class Image < ApplicationRecord
  validates :url, url: true
end
