# frozen_string_literal: true

# Taxon available to BiovisionComponent
#
# Attributes:
#   biovision_component_id [BiovisionComponent]
#   taxon_id [Taxon]
class TaxonComponent < ApplicationRecord
  belongs_to :taxon
  belongs_to :biovision_component

  validates_uniqueness_of :biovision_component_id, scope: :taxon_id
end
