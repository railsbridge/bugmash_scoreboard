class FeedJob < Struct.new(:feed_id)
  def perform
    Feed.find(feed_id).read!
    Delayed::Job.enqueue(FeedJob.new(feed_id), 0, Time.now + 15.minutes)
  end
end
