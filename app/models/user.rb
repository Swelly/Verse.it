class User < ActiveRecord::Base
  has_many :poems
  has_and_belongs_to_many :titles
  has_many :favorites
  has_many :poems, through: :favorites
end