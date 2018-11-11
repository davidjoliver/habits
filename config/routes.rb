Rails.application.routes.draw do
  resources :habits do
    post :check_in
  end

  resources :habit_records
  root to: "habits#index"
end
