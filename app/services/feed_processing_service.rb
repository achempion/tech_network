require 'net/http'

module FeedProcessingService
  module_function

  def call(website)
    content = Net::HTTP.get(URI(website.feed_url))
    feed = RssService.call(content)

    return if website.feed_synced_at && feed[:updated_at] <= website.feed_synced_at

    save_feed(website, feed)
  end

  class << self
    private

    def save_feed(website, feed)
      ActiveRecord::Base.transaction do
        feed[:items].each { |item| process_feed_item(website, item) }
        website.update!(feed_synced_at: DateTime.now)
      end
    end

    def process_feed_item(website, item)
      feed = website.posts.find_or_initialize_by(link: item[:link])

      return if feed.post_updated_at == item[:updated_at]

      feed.published_at ||= item[:updated_at]

      feed.update!(
        title: item[:title],
        description: item[:content],
        post_updated_at: item[:updated_at]
      )
    end
  end
end
