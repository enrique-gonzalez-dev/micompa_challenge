Rails.application.routes.draw do
  post :mutant, to: "people#create"
  get :stats, to: "people#stats"

  root to: "people#stats"
end