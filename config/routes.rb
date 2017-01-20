Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :jobs do
    collection do
      get :search
    end
  end
  root 'jobs#index'
  namespace :admin do
    resources :jobs do
      collection do
        get :search
      end
      member do
        post :publish
        post :hide
      end
    end
  end
  resources :subscriptions do
    member do
      get :verify
    end
  end

  get "/pages/:action" , :controller => "pages"

end
