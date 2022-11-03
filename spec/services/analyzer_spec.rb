require_relative '../../services/analyzer';

describe Analyzer do
  describe '.analyse_pages_by_query' do
    subject(:service) { Analyzer.new(pages: pages, query: queries.first).analyse_pages_by_query }

    let(:queries) { [WordRanking.new(group: 'Q1', keywords: { Ford: 8, Car: 7, OK: 6})] }
    let(:pages) { [WordRanking.new(group: 'P1', keywords: { Ford: 8, Car: 7, Me: 6})] }

    it "computes page weights by query" do
      pages_by_query = service

      expect(pages_by_query).to eq([["P1", 8 * 8 + 7 * 7]])
    end
  end
end
