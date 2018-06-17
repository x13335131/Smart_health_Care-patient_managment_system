Rails.application.routes.draw do
  get 'welcome/index'
   get 'patients/report'
   post'patients/report'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :patients
  resources :users 
 
  root 'welcome#index'
end
