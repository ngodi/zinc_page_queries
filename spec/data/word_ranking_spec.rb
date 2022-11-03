require_relative '../../data/word_ranking';

describe WordRanking do
  it "creates and saves word ranking object" do
    word_ranking = WordRanking.new(group: 'P1', keywords: { Ford: 8, Car: 7})

    expect(word_ranking).to be_instance_of(WordRanking)
    expect(word_ranking).to have_attributes(group: 'P1', keywords: { Ford: 8, Car: 7 })
    expect(word_ranking.keywords).to be_a(Hash)
  end
end
