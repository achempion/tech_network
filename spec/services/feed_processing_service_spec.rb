require 'rails_helper'

RSpec.describe FeedProcessingService, :type => :model do
  FEED_URL = "http://example.com"
  describe '#call' do
    let(:feed) { File.read("spec/fixtures/feeds/atom.xml") }


    before(:each) do
      expect(Net::HTTP).to receive(:get).with(URI(FEED_URL)).and_return(feed)
    end


    describe 'syncs rss feed' do
      let(:website) { create(:website, feed_url: FEED_URL) }

      subject { FeedProcessingService.call(website) }

      it do
        subject

        expect(Post.count).to eq(1)

        website = Website.first
        post = Post.first

        expect(website.feed_synced_at).to be >= 1.second.ago

        time = DateTime.parse("2003-12-13T18:30:02Z")
        expect(post.title).to eq("Atom-Powered Robots Run Amok")
        expect(post.post_updated_at).to eq(time)
        expect(post.published_at).to eq(time)
        expect(post.link).to eq("http://example.org/2003/12/13/atom03")
      end
    end

    describe  'skips sync if nothing updated' do
      let(:website) { create(:website, feed_url: FEED_URL, feed_synced_at: Time.now) }

      subject { FeedProcessingService.call(website) }

      it do
        expect(FeedProcessingService).to_not receive(:save_feed)

        subject
      end
    end
  end
end
