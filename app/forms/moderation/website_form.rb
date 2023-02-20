class Moderation::WebsiteForm
  attr_accessor :website, :feeds, :feed

  def initialize(website_params = {}, only_model = false)
    @website = Website.new(website_params)

    return if only_model

    @feeds = FeedsService.call(@website.url)
    @website.feed_url = nil if @feeds.exclude?(@website.feed_url)

    @feed = @website.feed_url && RssService.call(@website.feed_url)

    @website.feed_title = @feed ? @feed[:title] : ""
  end

  def valid?
    @website.valid?
  end

  def save!
    @website.save!
  end
end
