class User < ActiveRecord::Base
  attr_accessible :twitter, :u_id, :u_name

  has_many :poems
  has_and_belongs_to_many :titles
  has_many :favorites
  has_many :poems, through: :favorites
end
