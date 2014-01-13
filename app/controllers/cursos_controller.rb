class CursosController < ApplicationController
  # GET /cursos
  # GET /cursos.json
  def index
    @cursos = Curso.all
    @curso = Curso.new
    @programas = Programa.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cursos }
    end
  end

  # GET /cursos/1
  # GET /cursos/1.json
  def show
    @curso = Curso.find(params[:id])
    @cursos = Curso.all
    @sesion = Sesion.new
    @sesiones = @curso.sesions.order(:fecha)
    @alumno = Alumno.new
    @formulario_curso = FormularioCurso.new
    @formularios = @curso.formularios

    alumnos_ids = AlumnoCurso.where(:curso_id => @curso.id).select(:alumno_id).group(:alumno_id).collect{|p| p.alumno_id}
    @alumnos = Array.new
    alumnos_ids.each do |alumno_id|
      alumno = Alumno.find(alumno_id)
      @alumnos.push alumno
    end
    @alumnos.sort_by {|alumno| alumno.apellido_paterno}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @curso }
    end
  end

  # GET /cursos/new
  # GET /cursos/new.json
  def new
    @curso = Curso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @curso }
    end
  end

  # GET /cursos/1/edit
  def edit
    @curso = Curso.find(params[:id])
  end

  # POST /cursos
  # POST /cursos.json
  def create
    @curso = Curso.new(params[:curso])

    respond_to do |format|
      if @curso.save
        if params[:index] == "true"
          format.html { redirect_to cursos_path }
        else
          format.html { redirect_to programa_path(@curso.programa_id) }
        end
        format.json { render json: @curso, status: :created, location: @curso }
      else
        format.html { render action: "new" }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cursos/1
  # PUT /cursos/1.json
  def update
    @curso = Curso.find(params[:id])

    respond_to do |format|
      if @curso.update_attributes(params[:curso])
        if params[:index] == "true"
          format.html { redirect_to cursos_path }
        else
          format.html { redirect_to programa_path(@curso.programa_id) }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.json
  def destroy
    @curso = Curso.find(params[:id])
    @curso.destroy

    respond_to do |format|
      format.html { redirect_to cursos_url }
      format.json { head :no_content }
    end
  end

  def formulario
    @formulario = Formulario.find(params[:formulario_id])
    pagina = Nokogiri::HTML(open(@formulario.url))
    @cuerpo = pagina.css('form').to_html
    @curso = Curso.find(params[:curso_id])
  end

  def formulario_completado
    @formulario_curso = FormularioCurso.where(:formulario_id => params[:formulario_id], :curso_id => params[:curso_id]).first_or_create
    @formulario_curso.update_attributes(:estado => "Contestado")
  end
end
