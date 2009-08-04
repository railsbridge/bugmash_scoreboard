class Participant < ActiveRecord::Base
  has_many :actions
  
  validates_presence_of :name

  def self.find_author(author)
    first(:conditions => ['name = :author OR lighthouse_id = :author OR github_id = :author', {:author => author}])
  end
end
