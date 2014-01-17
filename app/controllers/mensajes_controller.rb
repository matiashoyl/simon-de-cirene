class MensajesController < ApplicationController
  # GET /mensajes
  # GET /mensajes.json
  def index
    @mensajes = Mensaje.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mensajes }
    end
  end

  # GET /mensajes/1
  # GET /mensajes/1.json
  def show
    @mensaje = Mensaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mensaje }
    end
  end

  # GET /mensajes/new
  # GET /mensajes/new.json
  def new
    @mensaje = Mensaje.new
  end

  # GET /mensajes/1/edit
  def edit
    @mensaje = Mensaje.find(params[:id])
  end

  # POST /mensajes
  # POST /mensajes.json
  def create
    @mensaje = Mensaje.new(:titulo => params[:mensaje][:titulo], :cuerpo => params[:mensaje][:cuerpo], :caracter => params[:mensaje][:caracter])

    respond_to do |format|
      if @mensaje.save
        params[:user_ids].each do |user_id|
          MensajeUsuario.create(:usuario_id => user_id, :mensaje_id => @mensaje.id)
        end
        format.html { redirect_to mensajes_path }
        format.json { render json: @mensaje, status: :created, location: @mensaje }
      else
        format.html { render action: "new" }
        format.json { render json: @mensaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mensajes/1
  # PUT /mensajes/1.json
  def update
    @mensaje = Mensaje.find(params[:id])

    respond_to do |format|
      if @mensaje.update_attributes(:titulo => params[:mensaje][:titulo], :cuerpo => params[:mensaje][:cuerpo], :caracter => params[:mensaje][:caracter])
        @mensaje.eliminar_receptores
        if params[:user_ids] != nil && params[:user_ids].kind_of?(Array)
          params[:user_ids].each do |user_id|
            MensajeUsuario.create(:usuario_id => user_id, :mensaje_id => @mensaje.id)
          end
        end
        format.html { redirect_to mensajes_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mensaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensajes/1
  # DELETE /mensajes/1.json
  def destroy
    @mensaje = Mensaje.find(params[:id])
    @mensaje.destroy

    receptores_ids = MensajeUsuario.where(:mensaje_id => params[:id]).select(:usuario_id).group(:usuario_id).collect{|p| p.usuario_id}
    receptores_ids.each do |receptor_id|
      MensajeUsuario.where(:usuario_id => receptor_id, :mensaje_id => params[:id]).destroy_all
    end

    respond_to do |format|
      format.html { redirect_to mensajes_url }
      format.json { head :no_content }
    end
  end

  def delete
    @mensaje = Mensaje.find(params[:id])
  end
end
