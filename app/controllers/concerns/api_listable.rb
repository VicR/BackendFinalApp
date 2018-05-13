# +ApiListable+ module
module ApiListable
  extend ActiveSupport::Concern

  protected

  def render_json_api_list_resource(collection: nil, search_fields: nil)
    filtered = filtered_collection(collection: collection, search_fields: search_fields)

    render json: filtered.collection, meta: filtered.meta_pagination
  end

  def filtered_collection(collection: nil, search_fields: nil)
    resource = ApiListResource.new(
      collection: collection,
      params: params,
      search_fields: search_fields
    )

    resource
  end

  # +ApiListResource+
  class ApiListResource
    module SortDirection
      ASC = 'asc'.freeze
      DESC = 'desc'.freeze

      LIST = { ASC => ASC, DESC => DESC }.freeze
    end

    attr_accessor :collection, :params, :search_fields

    def initialize(args = {})
      args.each { |k, v| send("#{k}=", v) }

      page_collection!
      order_collection!
      search_collection!
    end

    def page_collection!
      page = params[:page].to_i
      page = 1 if page.zero?

      self.collection = collection.page(page)
    end

    def search_collection!
      if search_fields.present? # rubocop:disable Style/GuardClause
        query = params[:globalSearch]
        search_resource = ApiSearchResource.new(
          fields: search_fields
        )

        self.collection = search_resource.search!(collection, query)
      end
    end

    def order_collection!
      sort_field = (params[:sort] || '').underscore
      sort_direction_key = (params[:sortDirection] || '').downcase
      sort_direction = SortDirection::LIST[sort_direction_key]

      if sort_field && sort_direction # rubocop:disable Style/GuardClause
        self.collection = collection.order(
          sort_field => sort_direction
        )
      end
    end

    def meta_pagination
      {
        itemsCount: collection.total_count,
        pagesCount: collection.total_pages
      }
    end
  end

  # +ApiSearchResource+
  class ApiSearchResource
    module Placeholder
      FIELD = '%FIELD%'.freeze
    end

    module Func
      UNACCENT = 'unaccent'.freeze
    end

    module Regex
      FIELD = ' '.freeze
      LIKE = 'ILIKE'.freeze
      OR = 'OR'.freeze
      WILDCARD = '%'.freeze
      ESCAPECHAR = '§'.freeze
      ESCAPE = /[!%_]/
    end

    module SearchType
      SEARCH_START = 1
      SEARCH_END = 2
    end

    attr_accessor :fields, :field_funcs

    def initialize(args = {})
      args.each { |k, v| send("#{k}=", v) }
    end

    def field_base
      @field_base ||= lambda do
        el = Placeholder::FIELD
        [Func::UNACCENT].each do |func|
          el = "#{func}(#{el})"
        end
        el
      end.call
    end

    def query_base
      @query_base ||= lambda do
        el = '?'
        [Func::UNACCENT].each do |func|
          el = "#{func}(#{el})"
        end
        el
      end.call
    end

    def get_term(term)
      term = term.gsub(Regex::ESCAPE) { |x| "#{Regex::ESCAPECHAR}#{x}" }
      tmp = SearchType::SEARCH_START
      search_type = SearchType::SEARCH_START | SearchType::SEARCH_END

      term = "#{Regex::WILDCARD}#{term}" if (search_type | tmp) == search_type
      tmp = SearchType::SEARCH_END
      term << Regex::WILDCARD if (search_type | tmp) == search_type
      term
    end

    def get_field(field, collection)
      if field.is_a?(Hash) # rubocop:disable Style/ConditionalAssignment
        field = "#{field[:table]}.#{field[:field]}"
      else
        field = "#{collection.table_name}.#{field}"
      end
      field_base.gsub(Placeholder::FIELD, field)
    end

    def search!(collection, val)
      res = collection
      if val.present?
        val.split(Regex::FIELD).each do |term|
          next if term.blank?
          parts = []
          terms = []
          fields.each do |f|
            field = get_field(f, collection)
            part = "#{field} #{Regex::LIKE} #{query_base} ESCAPE '#{Regex::ESCAPECHAR}'"
            terms << get_term(term)
            parts << part
          end
          if parts.any?
            query = parts.join(" #{Regex::OR} ")
            res = res.where(query, *terms)
          end
        end
      end
      res
    end
  end
end
