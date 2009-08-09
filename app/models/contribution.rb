class Contribution < ActiveRecord::Base
  belongs_to :participant

  validates_presence_of :lighthouse_id
  validates_numericality_of [:lighthouse_id, :point_value]

  named_scope :last_five, {:limit => 5, :order => 'created_at DESC', :include => :participant}
  named_scope :dummy, :conditions =>  {:id => 1}

  def self.new_ticket?(ticket_number)
    Contribution.count == 0 || ticket_number > Contribution.maximum(:lighthouse_id)
  end

  def self.up_or_down_vote?(content)
    content[/[+|-]1/]
  end

  def self.checked?(content)
    content[/(verified|reproduc)/i]
  end
  
  def self.changeset?(content)
    content[/\[\#(\d{3,}) (state|status):(resolved|committed)\]/]
  end

  def self.patch?(content)
    content[/attached a patch/i]
  end

  def self.extract_ticket_id(entry)
    pattern = /\[\#(\d{3,}).*\]/
    entry.title.scan(pattern)
    entry.content.scan(pattern) if $1.nil?
    $1.to_i
  end

  def self.process_entries(entries)
    entries.each do |entry|
      ticket_id = extract_ticket_id(entry)
      tracker = Tracker.create(:ticket_id => ticket_id, :saved_entry => entry)
      
      unless ticket_id.zero?
        running_total = 0
        
        if new_ticket?(ticket_id)
          running_total += 50
        else
          running_total += 25 if up_or_down_vote?(entry.content)
          running_total += 50 if checked?(entry.content)
          running_total += 1000 if changeset?(entry.content)
        end
        
        running_total += 100 if patch?(entry.content)

        unless running_total.zero?
          participant = Participant.find_or_create(entry.author)
          participant.contributions.create(:lighthouse_id => ticket_id,
                                           :point_value => running_total)
          participant.increment!(:score, running_total)
        end        
      end
    end
  end
end
