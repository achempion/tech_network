require 'rails_helper'

RSpec.describe RssService, :type => :model do
  describe '#call' do
    let(:feed) { File.read("spec/fixtures/feeds/atom.xml") }

    subject { RssService.call(feed) }

    it 'returns feed data' do
      expect(subject).to eq ({
        title: "Example Feed",
        updated_at: DateTime.parse("2003-12-13T18:30:02Z"),
        items: [
          {
            title: "Atom-Powered Robots Run Amok",
            link: "http://example.org/2003/12/13/atom03",
            updated_at: DateTime.parse("2003-12-13T18:30:02Z"),
            content: "Some text."
          }
        ]
      })
    end
  end
end
