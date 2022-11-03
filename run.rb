require './services/input_output.rb';
require_relative './data/store.rb';

InputOutput.get_input

InputOutput.show_top_pages(Store.get_queries_by_pages, 5)


