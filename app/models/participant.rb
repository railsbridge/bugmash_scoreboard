class Participant < ActiveRecord::Base
  acts_as_authentic
  has_many :actions
  
  validates_presence_of :name

  def self.find_by_author(author)
    first(:conditions => ['name = :author OR lighthouse_id = :author', {:author => author}])
  end
end
