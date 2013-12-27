class AlumnosController < ApplicationController
  # GET /alumnos
  # GET /alumnos.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
    @curso = Curso.find(params[:id])

    alumnos_ids = AlumnoCurso.where(:curso_id => @curso.id).select(:alumno_id).group(:alumno_id).collect{|p| p.alumno_id}
    @alumnos = Array.new
    alumnos_ids.each do |alumno_id|
      alumno = Alumno.find(alumno_id)
      @alumnos.push alumno
    end
    @alumnos.sort_by {|alumno| alumno.apellido_paterno}

    @sesiones = Sesion.where(:user_id => current_user).where(:curso_id => @curso.id).order(:fecha).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @curso.nombre + '.xls"'
        render "show.xls.erb"
      end
    end
  end

  # GET /alumnos/new
  # GET /alumnos/new.json
  def new
    @alumno = Alumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.new(:nombre => params[:alumno][:nombre], :apellido_paterno => params[:alumno][:apellido_paterno], :apellido_materno => params[:alumno][:apellido_materno], :rut => params[:alumno][:rut])

    respond_to do |format|
      if @alumno.save
        AlumnoCurso.create(:alumno_id => @alumno.id, :curso_id => params[:alumno][:curso_id])
        format.html { redirect_to sesion_curso_path(params[:alumno][:curso_id]) }
        format.json { render json: @alumno, status: :created, location: @alumno }
      else
        format.html { render action: "new" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      if @alumno.update_attributes(:nombre => params[:alumno][:nombre], :apellido_paterno => params[:alumno][:apellido_paterno], :apellido_materno => params[:alumno][:apellido_materno], :rut => params[:alumno][:rut])
        format.html { redirect_to sesion_curso_path(params[:alumno][:curso_id]) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:alumno_id])
    @alumno.destroy
    @alumno_curso = AlumnoCurso.where(:alumno_id => params[:alumno_id], :curso_id => params[:curso_id]).first
    @alumno_curso.destroy

    respond_to do |format|
      format.html { redirect_to sesion_curso_path(params[:curso_id]) }
      format.json { head :no_content }
    end
  end

  def import
    Alumno.import(params[:file], params[:curso_id])
    redirect_to sesion_curso_path(params[:curso_id])
  end

  def download_excel
    send_file("public/data/Excel Tipo.xlsx",
      :filename=> "Excel Tipo.xlsx",
      :type=>"application/xlsx",
      :x_sendfile=>true)
  end

  def asistencia
    AlumnoSesion.where(:alumno_id => params[:id], :sesion_id => params[:sesion]).first_or_create.update_attributes(:presente => params[:presente])
  end
end
