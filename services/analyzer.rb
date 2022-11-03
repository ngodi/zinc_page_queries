class Analyzer
  attr_reader :pages, :query

  # Initializes a new Analyzer class.
  # pages - The pages Array to be ranked/analyzed against the query keywords.
  # query - The query WordRanking object to analyze by page.
  #         group - The String representing the query by number.
  #         keywords -  The Hash containing the keywords for the query by weight.
  #                     word - The String representing the word.
  #                     weight - The Interger representing the relevance of word for the query.
  #
  def initialize(pages:, query:)
    @pages = pages
    @query = query
  end

  # Analyzes and returns all pages by provided query by ranking in deceasing order of match by query keywords.
  def analyse_pages_by_query
    pages_weights_by_query
  end

  private

  def pages_weights_by_query
    query_group = query.group
    query_keywords = query.keywords

    pages_for_query = []

    pages.each do |page|
      page_group = page.group
      page_keywords = page.keywords
  
      weight = 0
      page_keywords.each do |page_name, page_weight|
        if query_keywords[page_name]
          weight += query_keywords[page_name] * page_weight
        end
      end
  
      pages_for_query << [page_group, weight]
    end
  
    sort_pages_descending_weight(pages_for_query)
  end

  def sort_pages_descending_weight(pages)
    pages.sort_by { |page| -page[1] }
  end
end
