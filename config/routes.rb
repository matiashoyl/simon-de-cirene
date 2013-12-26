SimonDeCirene::Application.routes.draw do
  resources :alumnos do
    collection do
      post :import
    end
  end


  resources :sesions


  resources :cursos, :controller => "cursos"

  match "/cursos/:id", to: "cursos#update", :as => :update_curso, :via => :put
  match "/sesions/:id/details", to: "sesions#details", :as => :details, :via => :get
  match "/sesions/curso/:id", to: "sesions#curso", :as => :sesion_curso, :via => :get

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