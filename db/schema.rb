# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140116213707) do

  create_table "alumno_cursos", :force => true do |t|
    t.integer  "alumno_id"
    t.integer  "curso_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alumno_sesions", :force => true do |t|
    t.integer  "alumno_id"
    t.integer  "sesion_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "presente"
  end

  create_table "alumnos", :force => true do |t|
    t.string   "nombre"
    t.string   "rut"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "quintil"
    t.string   "direccion"
    t.string   "comuna"
    t.string   "num_telefono"
    t.string   "num_celular"
    t.date     "fecha_nacimiento"
    t.string   "sexo"
    t.string   "email"
    t.string   "escolaridad"
    t.string   "profesion"
    t.string   "actividad"
    t.string   "cargo"
    t.string   "rut_institucion"
    t.string   "nombre_institucion"
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "cursos", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "comuna"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "programa_id"
    t.integer  "relator_jefe_id"
  end

  create_table "formulario_cursos", :force => true do |t|
    t.integer  "formulario_id"
    t.integer  "curso_id"
    t.string   "estado"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "formularios", :force => true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tipo"
  end

  create_table "mensaje_usuarios", :force => true do |t|
    t.integer  "mensaje_id"
    t.integer  "usuario_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mensajes", :force => true do |t|
    t.string   "titulo"
    t.string   "cuerpo"
    t.string   "caracter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programas", :force => true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sesions", :force => true do |t|
    t.string   "tema"
    t.time     "hora_inicio"
    t.time     "hora_termino"
    t.date     "fecha"
    t.string   "tipo"
    t.string   "direccion"
    t.string   "comentario"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "curso_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
