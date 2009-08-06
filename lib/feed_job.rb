class FeedJob < Struct.new(:feed_id)
  def perform
    feed = Feed.find(feed_id)
    feed.read
    Contribution.process_entries(feed.reader.new_entries) if feed.reader.has_new_entries?
    feed.save
    Delayed::Job.enqueue(FeedJob.new(feed_id), 0, Time.now + 5.minutes)
  end
end
