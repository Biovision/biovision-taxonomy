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

  # @param [BiovisionComponent|Taxon] entity
  def self.[](entity)
    return unless [BiovisionComponent, Taxon].include?(entity.class)

    if entity.is_a?(BiovisionComponent)
      list = where(biovision_component: entity).pluck(:taxon_id).uniq
      Taxon.where(parent_id: nil, id: list)
    else
      list = where(taxon: entity).pluck(:biovision_component_id).uniq
      BiovisionComponent.where(id: list)
    end
  end
end
