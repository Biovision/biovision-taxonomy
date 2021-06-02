# frozen_string_literal: true

# Handling taxa
class Admin::TaxaController < AdminController
  include CrudEntities
  include ToggleableEntity

  before_action :set_entity, except: %i[check create index new search]

  # put /admin/taxa/:id/components/:component_id
  def add_component
    @entity.add_component(BiovisionComponent[params[:component_id]])

    head :no_content
  end

  # delete /admin/taxa/:id/components/:component_id
  def remove_component
    @entity.remove_component(BiovisionComponent[params[:component_id]])

    head :no_content
  end

  # put /admin/taxa/:id/users/:user_id
  def add_user
    @entity.add_user(User.find_by(id: params[:user_id]))

    head :no_content
  end

  # delete /admin/taxa/:id/users/:user_id
  def remove_user
    @entity.remove_user(User.find_by(id: params[:user_id]))

    head :no_content
  end

  private

  def component_class
    Biovision::Components::TaxonomyComponent
  end
end
