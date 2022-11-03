class WordRankingCreator
  attr_reader :group, :keywords

  # Initializes a new WordRankingCreator consisting of a page/query by it's keywords in deceasing order of relevance.
  #         group - The String representing the query by number.
  #         keywords -  The Hash containing the keywords for the query/page by weight.
  #                     word - The String representing the word.
  #                     weight - The Interger representing the relevance of word.
  #
  def initialize(group:, keywords:)
    @group = group
    @keywords = keywords
  end

  def create
    WordRanking.new(group: group, keywords: keywords)
  end
end
