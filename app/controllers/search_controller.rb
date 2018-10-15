class SearchController < ApplicationController
  include ApplicationHelper

  before_action :validate_query_is_present
  before_action :check_search_is_enabled

  def results
    @results = JSON.parse(get_results.to_json, object_class: OpenStruct).results
    @results_total = @results.sum(&:nbHits)
  end

  private

  def validate_query_is_present
    redirect_to root_path unless params['query']
  end

  def get_results # rubocop:disable Naming/AccessorMethodName
    return unless params['query']

    parameters = ALGOLIA_CONFIG.keys.map do |index|
      {
        index_name: index,
        query: params['query'],
        hitsPerPage: 20,
      }
    end

    Algolia.multiple_queries(parameters)
  end

  def search_error
    render 'search_error'
  end

  def check_search_is_enabled
    redirect_to root_path unless search_enabled?
  end
end
