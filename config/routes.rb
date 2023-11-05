Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, except: %i[update destroy] do
        put :update, on: :collection
        delete :destroy, on: :collection
        get '/user_hobbies', to: 'user_hobbies#index'
        # resources :user_hobbies, only: %i[index create delete]
      end
      post '/login', to: 'authentication#login'
      get '/my_profile', to: 'users#show_current_user'

      get '/games/start_game', to: 'games#start_game'
      post '/games/end_game', to: 'games#end_game'

      resources :hobbies, only: %i[index create destroy]
      resources :user_hobbies, only: %i[create delete]
      resources :progresses
    end
  end
end
