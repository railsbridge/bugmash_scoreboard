class Participant < ActiveRecord::Base
  has_many :actions
  
  validates_presence_of :name

  def self.find_or_create(author)
    first(:conditions => ['name = :author OR lighthouse_id = :author OR github_id = :author', {:author => author}]) || create(:name => author)
  end
end
