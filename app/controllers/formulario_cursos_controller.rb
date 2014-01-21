class FormularioCursosController < ApplicationController
  # GET /formulario_cursos
  # GET /formulario_cursos.json
  def index
    @formulario_cursos = FormularioCurso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @formulario_cursos }
    end
  end

  # GET /formulario_cursos/1
  # GET /formulario_cursos/1.json
  def show
    @formulario_curso = FormularioCurso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @formulario_curso }
    end
  end

  # GET /formulario_cursos/new
  # GET /formulario_cursos/new.json
  def new
    @formulario_curso = FormularioCurso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @formulario_curso }
    end
  end

  # GET /formulario_cursos/1/edit
  def edit
    @formulario_curso = FormularioCurso.find(params[:id])
  end

  # POST /formulario_cursos
  # POST /formulario_cursos.json
  def create
    @formulario_curso = FormularioCurso.new(params[:formulario_curso])

    respond_to do |format|
      if @formulario_curso.save
        format.html { redirect_to curso_path(@formulario_curso.curso_id) }
        format.json { render json: @formulario_curso, status: :created, location: @formulario_curso }
      else
        format.html { render action: "new" }
        format.json { render json: @formulario_curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /formulario_cursos/1
  # PUT /formulario_cursos/1.json
  def update
    @formulario_curso = FormularioCurso.find(params[:id])

    respond_to do |format|
      if @formulario_curso.update_attributes(params[:formulario_curso])
        format.html { redirect_to @formulario_curso }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @formulario_curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulario_cursos/1
  # DELETE /formulario_cursos/1.json
  def destroy
    @formulario_curso = FormularioCurso.find(params[:id])
    @formulario_curso.destroy

    respond_to do |format|
      format.html { redirect_to formulario_cursos_url }
      format.json { head :no_content }
    end
  end
end
