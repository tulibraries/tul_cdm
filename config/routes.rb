Rails.application.routes.draw do

  resources :digital_collections

  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  get 'subject_index' => 'high_voltage/pages#show', id: 'subject_index'
  get 'about' => 'high_voltage/pages#show', id: 'about'
  # The /cdm/ path will be deprecated in favor of /digital_collections/...
  get '/cdm/stereotypicalabout' => 'high_voltage/pages#show', id: 'stereotypicalabout'
  get '/digital_collections/stereotypicalimages/about' => 'high_voltage/pages#show', id: 'stereotypicalabout'
  get 'catalog/multiselect_facet/:id', to: 'catalog#multiselect_facet'
  get '/cdm/restricted', to: 'digital_collections#restricted'
  get 'pages/about_collections' => 'high_voltage/pages#show', id: 'about_collections'
  get 'pages/learning_static_pages' => 'high_voltage/pages#show', id: 'learning_static_pages'

end
