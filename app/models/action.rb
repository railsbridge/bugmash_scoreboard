class Action < ActiveRecord::Base
  belongs_to :participant

  validates_presence_of :lighthouse_id
  validates_numericality_of [:lighthouse_id, :point_value]

  def self.new_ticket?(ticket_number)
    Action.count == 0 || ticket_number > Action.maximum(:lighthouse_id)
  end

  def self.up_or_down_vote?(content)
    content[/[+|-]1/]
  end

  def self.checked?(content)
    content[/(verified|no[nt].reproduc)/i]
  end
  
  def self.changeset?(content)
    content[/\[\#(\d{3,}) state:resolved\]/]
  end

  def self.extract_ticket_id(entry)
    pattern = /\[\#(\d{3,}).*\]$/
    entry.title.scan(pattern)
    entry.content.scan(pattern) if $1.nil?
    $1.to_i
  end

  def self.process_entries(entries)
    entries.each do |entry|
      ticket_id = extract_ticket_id(entry)
      unless ticket_id.zero?
        participant = Participant.find_or_create(entry.author)
        action = participant.actions.new(:lighthouse_id => ticket_id)
        running_total = 0
        
        running_total += 50 if new_ticket?(action.lighthouse_id)
        running_total += 25 if up_or_down_vote?(entry.content)
        running_total += 50 if checked?(entry.content)
        running_total += 1000 if changeset?(entry.content)

        action.point_value = running_total
        action.save
      end
    end
  end
end
