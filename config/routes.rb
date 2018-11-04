Rails.application.routes.draw do
  resources :habits
  root to: "habits#index"
end
