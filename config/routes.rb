Rails.application.routes.draw do
  get 'games/search'
  root 'static_pages#top'
 
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_use', to: 'static_pages#terms_of_use'
  get 'treatment', to: 'players#treatment'
  resources :users, only: %i(new create show)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :players, only: %i[show] do
    # resources :favorite 
    post 'favorite' => 'favorites#create'
    delete 'favorite' => 'favorites#destroy'
    collection do 
      get 'search'
      get 'favorites' 
    end
  end

  #resources :favorites, only: %i[create destroy]

  resource :games, only: %i[show] do
    collection do 
      get 'search'   
    end
  end
end
