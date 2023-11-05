Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: %i[update destroy] do
        put :update, on: :collection
        delete :destroy, on: :collection
      end
      post '/login', to: 'authentication#login'
      get '/my_profile', to: 'users#show_current_user'

      get '/games/start_game', to: 'games#start_game'
      post '/games/end_game', to: 'games#end_game'

      resources :hobbies
      resources :progresses
    end
  end
end
