class Website < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :url, presence: true
  validates :feed_title, presence: true
  validates :feed_url, presence: true, uniqueness: true
end
