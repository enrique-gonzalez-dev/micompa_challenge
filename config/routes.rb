Rails.application.routes.draw do
  resources :people

  post :mutant, to: "people#create"
  get :stats, to: "people#stats"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
