class Tracker < ActiveRecord::Base
  serialize :saved_entry

  named_scope :not_processed, :conditions => { :ticket_id => 0, :ignore => false }
end
