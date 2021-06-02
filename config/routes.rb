# frozen_string_literal: true

Rails.application.routes.draw do
  concern :check do
    post :check, on: :collection, defaults: { format: :json }
  end

  concern :priority do
    post :priority, on: :member, defaults: { format: :json }
  end

  concern :search do
    get :search, on: :collection
  end

  concern :toggle do
    post :toggle, on: :member, defaults: { format: :json }
  end

  namespace :admin do
    # Taxonomy
    resources :taxa, concerns: %i[check priority search toggle] do
      member do
        put 'components/:component_id' => :add_component, as: :component
        delete 'components/:component_id' => :remove_component
        put 'users/:user_id' => :add_user, as: :user
        delete 'users/:user_id' => :remove_user
      end
    end
  end
end
