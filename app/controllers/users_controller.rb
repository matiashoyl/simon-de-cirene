class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @curso = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curso }
    end
  end
  
  def create
    authorize! :create, @user, :message => 'Not authorized as an administrator.'
    password = Devise.friendly_token.first(8)
    @user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role_ids => params[:user][:role_ids], :password => password, :password_confirmation => password)
    UserMailer.welcome(@user, password).deliver
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Usuario creado exitosamente' }
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
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end