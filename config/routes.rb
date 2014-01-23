SimonDeCirene::Application.routes.draw do
  resources :mensaje_usuarios


  resources :mensajes

  match "/mensajes/:id/delete", to: "mensajes#delete", :as => :delete_mensaje, :via => :get

  match "/not_authorized", to: "home#not_authorized", :as => :not_authorized, :via => :get

  match "/mensajes/new/:id", to: "mensajes#new_with_receiver", :as => :new_mensaje_with_receiver, :via => :get

  resources :formulario_cursos


  resources :formularios do
    collection do
      post :asignar
    end
  end

  match "/formulario/:id/delete", to: "formularios#delete", :as => :delete_formulario, :via => :get
  match "/formulario/:id/asign", to: "formularios#asign", :as => :asign_formulario, :via => :get
  match "/formulario/:id/repeat", to: "formularios#repeat", :as => :repeat_formulario, :via => :get
  match "/formulario/:id/repeat", to: "formularios#repetir", :as => :repetir_formulario, :via => :post
  match "/formulario/resumen", to: "formularios#resumen", :as => :resumen_formularios, :via => :get

  resources :programas

  match "/programas/:id/delete", to: "programas#delete", :as => :delete_programa, :via => :get
  match "/programas/:id/set_active", to: "programas#set_active", :as => :programa_set_active, :via => :post
  match "/programas_inactivos", to: "programas#index_inactivos", :as => :programas_inactivos, :via => :get
  match "/programas_inactivos/:id", to: "programas#show_inactivos", :as => :programa_inactivo, :via => :get


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
  match "/cursos/:id/asistencia", to: "sesions#asistencia", :as => :asistencia_curso, :via => :get
  match "/curso/resumen", to: "cursos#resumen", :as => :resumen_cursos, :via => :get
  match "/cursos_inactivos", to: "cursos#index_inactivos", :as => :cursos_inactivos, :via => :get
  match "/cursos_inactivos/:id", to: "cursos#show_inactivos", :as => :curso_inactivo, :via => :get
  match "/curso_inactivo/resumen", to: "cursos#resumen_inactivos", :as => :resumen_cursos_inactivos, :via => :get

  match "/cursos/:id", to: "cursos#update", :as => :update_curso, :via => :put
  match "/sesions/:id/details", to: "sesions#details", :as => :sesion_details, :via => :get
  match "/alumnos/:id/details", to: "alumnos#details", :as => :alumno_details, :via => :get
  match "/sesions/curso/:id", to: "sesions#curso", :as => :sesion_curso, :via => :get
  match "/alumnos/asistencia/:id", to: "alumnos#asistencia", :via => :post
  match "/download/excel_tipo", to: "alumnos#download_excel"
  match "/curso/:curso_id/formulario/:formulario_id", to: "cursos#formulario", :as => :curso_formulario, :via => :get
  match "/curso/:curso_id/formulario/:formulario_id", to: "cursos#formulario_completado", :via => :post
  match "/ayuda/formularios", to: "home#ayuda_formularios", :as => :ayuda_formulario, :via => :get
  match "/cursos/importar_excel_sence", to: "alumnos#import_sence", :as => :import_excel_sence, :via => :post
  match "/resumen/programa/:id", to: "home#resumen_programa", :as => :resumen_programa, :via => :get
  match "/resumen/curso/:id", to: "home#resumen_curso", :as => :resumen_curso, :via => :get

  authenticated :user do
    root :to => 'home#index'
  end

  match "/user/:id/delete", to: "users#delete", :as => :delete_user, :via => :get

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