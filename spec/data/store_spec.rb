require_relative '../../data/store';
require_relative '../../data/word_ranking';

describe Store do

  let(:page_ranking) { WordRanking.new(group: 'P1', keywords: { Ford: 8, Car: 7}) }
  let(:query_ranking) { WordRanking.new(group: 'Q1', keywords: { Ford: 8, Car: 7}) }

  describe '.add_to_store' do
    it "adds page to pages record" do
      Store.add_to_store(page: page_ranking)
  
      expect(Store.get_pages.count).to eq(1)
     end
  
     it "adds query to queries record" do
      Store.add_to_store(query: query_ranking)
  
      expect(Store.get_queries.count).to eq(1)
     end
  end
end