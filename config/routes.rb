Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  resources :jobs do
    resources :resumes
    collection do
      get :search
    end
  end
  namespace :admin do
    resources :jobs do
      collection do
        get :search
      end
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end
  resources :subscriptions do
    member do
      get :verify
    end
  end

  get "/pages/:action" , :controller => "pages"

end
