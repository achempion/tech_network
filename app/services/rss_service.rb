module RssService
  module_function

  def call(content)
    feed = RSS::Parser.parse(content)

    case feed.feed_type
    when "atom"
      atom_feed(feed)
    else
      raise "unknown feed type: #{feed.feed_type}"
    end
  end

  def atom_feed(feed)
    {
      title: feed.title.content,
      updated_at: feed.updated.content,
      items:  feed.items.map do |entry|
        {
          title: entry.title.content,
          updated_at: entry.updated.content,
          link: entry.link.href,
          content: entry.content&.content || entry.summary&.content
        }
      end
    }
  end
end
