require_relative '../data/word_ranking.rb';
require_relative '../data/store.rb';
require_relative './analyzer.rb';
require_relative './word_ranking_creator.rb';

module InputOutput
  class << self
    MAX_WEIGHT = 8 
    MIN_WEIGHT = 1
    PAGE = 'P'
    QUERY = 'Q'

    # Gets file input log of pages and quesries from th STDINPUT and stores into the program.
    def get_input
      page_count = 1
      query_count = 1

      File.readlines(ARGV.first).each do |line|
        line = line.split(' ')
        group = line&.shift&.upcase

        next unless [PAGE, QUERY].include?(group)

        keywords = weights_by_keywords(line)

        if group == PAGE 
          group = "#{group}#{page_count}"
          page_group = WordRankingCreator.new(group: group, keywords: keywords).create

          Store.add_to_store(page: page_group) 
          page_count += 1

        elsif group == QUERY
          group = "#{group}#{query_count}"
          query_group = WordRankingCreator.new(group: group, keywords: keywords).create

          Store.add_to_store(query: query_group)
          query_count += 1
        end
      end
    end

    # Prints queries alongside their pages in decreasing order of relevance.
    def show_top_pages(records, limit)
      group_pages_by_queries

      records.each do |query, pages|
        pages = filter_page_by_weight(pages, 0)
        output_pages = pages.take(limit).map { |page| page[0] }.join(' ')
      
        puts "#{query}: #{output_pages}"
      end
    end


    private

    def group_pages_by_queries
      Store.get_queries.each do |query|
        Store.get_queries_by_pages[query.group] = Analyzer.new(pages: Store.get_pages, query: query).analyse_pages_by_query
      end
    end


    def filter_page_by_weight(pages, weight)
      pages.select { |page| page[1] > weight }
    end

    def create_group(line, group, count)
      keywords = weights_by_keywords(line)
    
      WordRanking.new(group: "#{group}#{count}", keywords: keywords)
    end

    def weights_by_keywords(line)
      weight_count = MAX_WEIGHT
    
      keywords = {}

      line.each do |word|
        word = word.upcase

        break unless weight_count >= MIN_WEIGHT

        keywords[word] = weight_count
    
        weight_count -= 1
      end

      keywords
    end
  end
end
