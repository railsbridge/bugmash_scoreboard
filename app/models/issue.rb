class Issue < ActiveRecord::Base
  validates_presence_of [:contributor_name, :details]
  validates_numericality_of :lighthouse_id, :allow_blank => true
end
