Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
  	resources :categories
  end

  match 'api/get_second_level/:fq_id' => 'api/categories#get_second_level', :as => :get_second_level, defaults: { format: "json" }, :via => :get
  match 'api/get_third_level/:fq_id' => 'api/categories#get_third_level', :as => :get_third_level, defaults: { format: "json" }, :via => :get

  root to: 'visitors#index'
end
