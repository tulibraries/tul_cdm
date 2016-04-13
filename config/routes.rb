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
  get 'pages/ml_blitzstein_and_co' => 'high_voltage/pages#show', id: 'ml_blitzstein_and_co'
  get 'pages/m_rosenbaum_and_co' => 'high_voltage/pages#show', id: 'm_rosenbaum_and_co'
  get 'pages/rosenbluth_brothers' => 'high_voltage/pages#show', id: 'rosenbluth_brothers'
  get 'pages/pennsylvania_company_for_banking_and_trusts' => 'high_voltage/pages#show', id: 'pennsylvania_company_for_banking_and_trusts'
  get 'pages/searching_the_ledgers' => 'high_voltage/pages#show', id: 'searching_the_ledgers'
  get 'pages/philadelphias_steamship_agents' => 'high_voltage/pages#show', id: 'philadelphias_steamship_agents'

end
