Rails.application.routes.draw do
  get 'static_pages/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'static_pages/home'
  get 'maps/oscmap'
  root 'maps#oscmap'
  post  'maps/update', to: 'maps#update', as: 'maps_update'
end
