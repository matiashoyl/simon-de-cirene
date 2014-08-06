class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.order(:created_at)
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    authorize! :create, @user, :message => 'Not authorized as an administrator.'
    password = Devise.friendly_token.first(8)
    @user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role_ids => params[:user][:role_ids], :password => password, :password_confirmation => password)
    respond_to do |format|
      if @user.save
        UserMailer.welcome(@user, password).deliver
        format.html { redirect_to users_path }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path
    else
      redirect_to users_path, :alert => "No se pudo actualizar el usuario"
    end
  end

  def delete
    @user = User.find(params[:id])
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      if user.has_role? :relator
        if user.cursos.any?
          cursos = user.cursos
          UsuarioMensaje.where(:usuario_id => user).destroy_all
          user.destroy
          relatores = User.with_role :relator
          cursos.each do |curso|
            curso.update_attributes(:relator_jefe_id => relatores.sample.id)
          end
          redirect_to users_path
        else
          UsuarioMensaje.where(:usuario_id => user).destroy_all
          user.destroy
          redirect_to users_path
        end
        
      else
        user.destroy
        redirect_to users_path
      end
    else
      redirect_to users_path, :alert => "No te puedes eliminar a ti mismo"
    end
  end

  def update_password
    @user = User.find(current_user.id)
    password = params[:user][:password]
    #debugger
    if @user.update_attributes(:password => password, :password_confirmation => params[:user][:password_confirmation])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Contraseña cambiada"
      UserMailer.password_changed(@user, password).deliver
    else
      redirect_to root_path, :alert => "No se pudo cambiar la contraseña"
    end
  end
end