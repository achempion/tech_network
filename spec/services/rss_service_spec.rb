require 'rails_helper'

RSpec.describe RssService, :type => :model do
  describe '#call' do
    it 'returns feed data' do
      puts RssService.call
    end
  end
end
