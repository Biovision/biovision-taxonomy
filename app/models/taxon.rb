# frozen_string_literal: true

# Taxon
#
# Attributes:
#   children_cache [Array<integer>]
#   created_at [DateTime]
#   data [jsonb]
#   name [string]
#   nav_text [string]
#   object_count [integer]
#   parent_id [integer], optional
#   parents_cache [string]
#   priority [integer]
#   simple_image_id [SimpleImage], optional
#   slug [string]
#   updated_at [DateTime]
#   uuid [uuid]
#   visible [boolean]
class Taxon < ApplicationRecord
  include Checkable
  include HasSimpleImage
  include HasUuid
  include NestedPriority
  include Toggleable
  include TreeStructure

  SLUG_LIMIT = 50

  toggleable :visible

  has_many :taxon_components, dependent: :delete_all
  has_many :taxon_users, dependent: :delete_all
  has_many :biovision_components, through: :taxon_components
  has_many :users, through: :taxon_users

  before_validation { self.slug = nil if slug.blank? }
  validates_presence_of :name
  validates_uniqueness_of :slug, scope: :parent_id, allow_nil: true

  scope :ordered_by_name, -> { order('name asc') }
  scope :visible, -> { where(visible: true) }
  scope :list_for_administration, -> { included_image.ordered_by_priority }
  scope :search, ->(q) { where('name ilike ?', "#{q}%") unless q.blank? }

  def self.page_for_administration(*)
    where(parent: nil).list_for_administration
  end

  # @param [String] slug
  def self.[](slug)
    find_by(parent: nil, slug: slug)
  end

  # @param [Taxon] entity
  def self.siblings(entity)
    where(parent_id: entity&.parent_id)
  end

  def self.entity_parameters
    %i[name nav_text priority simple_image_id slug visible]
  end

  def self.creation_parameters
    entity_parameters + %i[parent_id]
  end

  def self.json_attributes
    %i[name slug nav_text parent_id parents_cache children_cache]
  end

  def text_for_link
    nav_text.blank? ? name : nav_text
  end

  def long_name
    (parents.map(&:name) + [text_for_link]).join('/')
  end

  def object_count!
    Taxon.where(id: subbranch_ids).sum(:object_count)
  end

  # @param [BiovisionComponent] entity
  def component?(entity)
    taxon_components.where(biovision_component: entity).exists?
  end

  # @param [BiovisionComponent] entity
  def add_component(entity)
    taxon_components.where(biovision_component: entity).create
  end

  # @param [BiovisionComponent] entity
  def remove_component(entity)
    taxon_components.where(biovision_component: entity).delete_all
  end

  # @param [User] entity
  def user?(entity)
    taxon_users.where(user: entity).exists?
  end

  # @param [User] entity
  def add_user(entity)
    taxon_users.where(user: entity).create
  end

  # @param [User] entity
  def remove_user(entity)
    taxon_users.where(user: entity).delete_all
  end
end
