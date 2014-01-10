SimonDeCirene::Application.routes.draw do
  resources :formulario_cursos


  resources :formularios


  resources :programas


  resources :alumnos do
    collection do
      post :import
      post :search
    end
  end


  resources :sesions


  resources :cursos, :controller => "cursos"

  match "/cursos/:id", to: "cursos#update", :as => :update_curso, :via => :put
  match "/sesions/:id/details", to: "sesions#details", :as => :sesion_details, :via => :get
  match "/alumnos/:id/details", to: "alumnos#details", :as => :alumno_details, :via => :get
  match "/sesions/curso/:id", to: "sesions#curso", :as => :sesion_curso, :via => :get
  match "/alumnos/asistencia/:id", to: "alumnos#asistencia", :via => :post
  match "/download/excel_tipo", to: "alumnos#download_excel"
  match "/curso/:curso_id/formulario/:formulario_id", to: "cursos#formulario", :as => :curso_formulario, :via => :get
  match "/curso/:curso_id/formulario/:formulario_id", to: "cursos#formulario_completado", :via => :post
  match "/ayuda/formularios", to: "home#ayuda_formularios", :as => :ayuda_formulario, :via => :get

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