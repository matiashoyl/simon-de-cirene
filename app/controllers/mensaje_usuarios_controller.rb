class MensajeUsuariosController < ApplicationController
  # GET /mensaje_usuarios
  # GET /mensaje_usuarios.json
  def index
    @mensaje_usuarios = MensajeUsuario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mensaje_usuarios }
    end
  end

  # GET /mensaje_usuarios/1
  # GET /mensaje_usuarios/1.json
  def show
    @mensaje_usuario = MensajeUsuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mensaje_usuario }
    end
  end

  # GET /mensaje_usuarios/new
  # GET /mensaje_usuarios/new.json
  def new
    @mensaje_usuario = MensajeUsuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mensaje_usuario }
    end
  end

  # GET /mensaje_usuarios/1/edit
  def edit
    @mensaje_usuario = MensajeUsuario.find(params[:id])
  end

  # POST /mensaje_usuarios
  # POST /mensaje_usuarios.json
  def create
    @mensaje_usuario = MensajeUsuario.new(params[:mensaje_usuario])

    respond_to do |format|
      if @mensaje_usuario.save
        format.html { redirect_to @mensaje_usuario, notice: 'Mensaje usuario was successfully created.' }
        format.json { render json: @mensaje_usuario, status: :created, location: @mensaje_usuario }
      else
        format.html { render action: "new" }
        format.json { render json: @mensaje_usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mensaje_usuarios/1
  # PUT /mensaje_usuarios/1.json
  def update
    @mensaje_usuario = MensajeUsuario.find(params[:id])

    respond_to do |format|
      if @mensaje_usuario.update_attributes(params[:mensaje_usuario])
        format.html { redirect_to @mensaje_usuario, notice: 'Mensaje usuario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mensaje_usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensaje_usuarios/1
  # DELETE /mensaje_usuarios/1.json
  def destroy
    @mensaje_usuario = MensajeUsuario.find(params[:id])
    @mensaje_usuario.destroy

    respond_to do |format|
      format.html { redirect_to mensaje_usuarios_url }
      format.json { head :no_content }
    end
  end
end
