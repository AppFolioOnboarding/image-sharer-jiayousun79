class Image < ApplicationRecord
  acts_as_taggable
  validates :url, url: true
end
