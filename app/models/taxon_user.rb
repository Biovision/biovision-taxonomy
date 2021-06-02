# frozen_string_literal: true

# Taxon available to user
#
# Attributes:
#   data [JSONb]
#   user_id [User]
#   taxon_id [Taxon]
class TaxonUser < ApplicationRecord
  include HasOwner

  belongs_to :taxon
  belongs_to :user

  validates_uniqueness_of :taxon_id, scope: :user_id

  # @param [User|Taxon] entity
  def self.[](entity)
    return unless [User, Taxon].include?(entity.class)

    if entity.is_a?(User)
      list = where(user: entity).pluck(:taxon_id).uniq
      Taxon.where(parent_id: nil, id: list)
    else
      list = where(taxon: entity).pluck(:user_id).uniq
      User.where(id: list)
    end
  end
end
