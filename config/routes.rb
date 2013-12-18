SimonDeCirene::Application.routes.draw do
  resources :cursos, :controller => "cursos"

  match "/cursos/:id", to: "cursos#update", :as => :update_curso, :via => :put

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :skip => [:registrations]
  devise_scope :user do
  	post "user_registration", 		:to => "users#create"
  	get "edit_user_registration",   :to => "users#edit"
  end
  resources :users, :controller => "users"
  resource :user, only: [:edit] do
    collection do
      put 'update_password'
    end
  end
end