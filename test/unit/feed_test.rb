require File.join(File.dirname(__FILE__), '..', 'test_helper')

class FeedTest < ActiveSupport::TestCase
  context '#read' do
    setup do 
      @feed = Factory(:feed)
      reader = Feedzirra::Parser::Atom.new
      reader.title = 'Test'
      reader.feed_url = @feed.url
      entry = Feedzirra::Parser::AtomEntry.new
      entry.published = Time.now.to_s
      reader.entries << entry
      mock(Feedzirra::Feed).fetch_and_parse(@feed.url) { reader }
    end

    should 'initalize reader if nil' do
      assert_nil @feed.reader
      @feed.read
      assert_not_nil @feed.reader
    end
  end

  context 'on save' do
    setup do 
      @feed = Factory(:feed)
      reader = Feedzirra::Parser::Atom.new
      reader.title = 'Test'
      reader.feed_url = @feed.url
      2.times do
        entry = Feedzirra::Parser::AtomEntry.new
        entry.published = Time.now.to_s
        reader.entries << entry
      end

      mock(Feedzirra::Feed).fetch_and_parse(@feed.url) { reader }
    end

    should 'trim the entries list to contain only the most current' do
      @feed.read
      assert 2, @feed.reader.entries.size

      @feed.save!
      @feed.reload
      assert_equal 1, @feed.reader.entries.size
    end
  end
end
