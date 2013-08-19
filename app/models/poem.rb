class Poem < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :favorites

  # validates :user, presence: true
  validates :source_user, length: {minimum: 1}
  validates :text, length: {minimum: 1}
end