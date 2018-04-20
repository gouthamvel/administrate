require_relative "associative"
require_relative "has_many"

module Administrate
  module Field
    class BelongsTo < Associative
      DEFAULT_ASSOCIATED_LIMIT = HasMany::DEFAULT_ASSOCIATED_LIMIT

      def self.permitted_attribute(attr, _options = nil)
        :"#{attr}_id"
      end

      def permitted_attribute
        foreign_key
      end

      def associated_resource_options
        [nil] + candidate_resources.map do |resource|
          [display_candidate_resource(resource), resource.send(primary_key)]
        end
      end

      def ajax_resource_options
        if selected_option.nil?
          []
        else
          resource = candidate_resources.find(selected_option)
          [
            [display_candidate_resource(resource), resource.send(primary_key)]
          ]
        end
      end

      def selected_option
        data && data.send(primary_key)
      end

      def load_with_ajax?
        associated_class.count > DEFAULT_ASSOCIATED_LIMIT
      end

      private

      def candidate_resources
        scope = options[:scope] ? options[:scope].call : associated_class.all

        order = options.delete(:order)
        order ? scope.reorder(order) : scope
      end

      def display_candidate_resource(resource)
        associated_dashboard.display_resource(resource)
      end
    end
  end
end
