SimonDeCirene::Application.routes.draw do
  resources :formulario_cursos


  resources :formularios do
    collection do
      post :asignar
    end
  end


  resources :programas

  match "/programas/:id/delete", to: "programas#delete", :as => :delete_programa, :via => :get


  resources :alumnos do
    collection do
      post :import
      post :search
    end
  end

  match "/cursos/:curso_id/delete_alumno/:id", to: "alumnos#delete", :as => :delete_alumno, :via => :get
  match "/cursos/:id/new_alumno", to: "alumnos#new", :as => :new_alumno, :via => :get
  match "/cursos/:curso_id/edit_alumno/:id", to: "alumnos#edit", :as => :edit_alumno, :via => :get


  resources :sesions

  match "/sesion/:id/delete", to: "sesions#delete", :as => :delete_sesion, :via => :get
  match "/cursos/:id/new_sesion", to: "sesions#new", :as => :new_sesion, :via => :get


  resources :cursos, :controller => "cursos"

  match "/cursos/:id/delete", to: "cursos#delete", :as => :delete_curso, :via => :get

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