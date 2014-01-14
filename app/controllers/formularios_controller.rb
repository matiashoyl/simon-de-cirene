require 'rubygems'
require 'nokogiri'
require 'open-uri'

class FormulariosController < ApplicationController
  # GET /formularios
  # GET /formularios.json
  def index
    @formularios = Formulario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @formularios }
    end
  end

  # GET /formularios/1
  # GET /formularios/1.json
  def show
    @formulario = Formulario.find(params[:id])
    pagina = Nokogiri::HTML(open(@formulario.url))
    @cuerpo = pagina.css('form').to_html

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @formulario }
    end
  end

  # GET /formularios/new
  # GET /formularios/new.json
  def new
    @formulario = Formulario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @formulario }
    end
  end

  # GET /formularios/1/edit
  def edit
    @formulario = Formulario.find(params[:id])
  end

  # POST /formularios
  # POST /formularios.json
  def create
    @formulario = Formulario.new(params[:formulario])

    respond_to do |format|
      if @formulario.save
        format.html { redirect_to formularios_path }
        format.json { render json: @formulario, status: :created, location: @formulario }
      else
        format.html { render action: "new" }
        format.json { render json: @formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /formularios/1
  # PUT /formularios/1.json
  def update
    @formulario = Formulario.find(params[:id])

    respond_to do |format|
      if @formulario.update_attributes(params[:formulario])
        format.html { redirect_to formularios_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @formulario.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @formulario = Formulario.find(params[:id])
  end

  # DELETE /formularios/1
  # DELETE /formularios/1.json
  def destroy
    @formulario = Formulario.find(params[:id])
    @formulario.destroy

    FormularioCurso.where(:formulario_id => @formulario).destroy_all

    respond_to do |format|
      format.html { redirect_to formularios_url }
      format.json { head :no_content }
    end
  end

  def asign
    @formulario = Formulario.find(params[:id])
  end

  def asignar
    formulario_id = params[:formulario_id]
    params[:cursos_ids].each do |curso_id|
      FormularioCurso.create(:curso_id => curso_id, :formulario_id => formulario_id, :estado => "Pendiente" )
    end
    redirect_to formularios_path
  end
end
