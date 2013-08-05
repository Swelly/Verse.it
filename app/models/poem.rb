class Poem < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :favorites
end