class Title < ActiveRecord::Base
  attr_accessible :title, :image

  has_and_belongs_to_many :users
end