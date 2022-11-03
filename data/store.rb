module Store
  @pages = []
  @queries = []
  @queries_by_pages = {}

  class << self

    # Adds new WordRanking query and page objects to the queries and @pages arrays respectively.
    def add_to_store(page: nil, query: nil)
      @pages << page unless page.nil?
      @queries << query unless query.nil?
    end

    # Returns the all the pages processed and stored.
    def get_pages
      @pages
    end

    # Returns the all the queries processed and stored.
    def get_queries
      @queries
    end

    # Returns all the queries by their pages in order of relevance match.
    def get_queries_by_pages
      @queries_by_pages
    end
  end
end
