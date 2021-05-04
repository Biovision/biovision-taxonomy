# frozen_string_literal: true

module Biovision
  module Components
    # Taxonomy
    class TaxonomyComponent < BaseComponent
      def self.dependent_models
        [Taxon, TaxonUser, TaxonComponent]
      end

      def use_images?
        true
      end

      def administrative_parts
        %w[taxa]
      end

      def crud_table_names
        %w[taxa]
      end

      def role_tree
        super.merge({ Taxon.table_name => %w[users components] })
      end
    end
  end
end
