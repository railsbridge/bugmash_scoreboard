class Feed < ActiveRecord::Base
  before_save :trim_entries
  serialize :reader

  def read
    if reader.blank?
      self.reader = Feedzirra::Feed.fetch_and_parse(url)
    else
      reader.update_from_feed(Feedzirra::Feed.fetch_and_parse(url))
    end
  end

  protected

  def trim_entries
    self.reader.entries = [reader.entries.first] unless reader.blank?
  end
end
