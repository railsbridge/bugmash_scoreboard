class FeedJob < Struct.new(:feed_id)
  def perform
    feed = Feed.find(feed_id)
    feed.read
    # processing goes on right here
    feed.save
    Delayed::Job.enqueue(FeedJob.new(feed_id), 0, Time.now + 15.minutes)
  end
end
