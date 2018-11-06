Rails.application.routes.draw do
  resources :habits
  resources :habit_records
  root to: "habits#index"
end
