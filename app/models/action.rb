class Action < ActiveRecord::Base
  belongs_to :participant

  validates_presence_of :lighthouse_id
  validates_numericality_of [:lighthouse_id, :point_value]
end
