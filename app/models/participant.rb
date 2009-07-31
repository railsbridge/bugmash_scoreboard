class Participant < ActiveRecord::Base
  acts_as_authentic
  has_many :actions
  
  validates_presence_of :name
end
