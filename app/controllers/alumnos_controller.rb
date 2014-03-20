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

    if current_user.has_role? :relator
      @sesiones = Sesion.where(:user_id => current_user, :active => true).where(:curso_id => @curso.id).order(:fecha).all
    else
      @sesiones = Sesion.where(:curso_id => @curso.id, :active => true).order(:fecha).all
    end
    
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
    @curso = Curso.find(params[:id])
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
    @curso = Curso.find(params[:curso_id])
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    @alumno = Alumno.where(:rut => params[:alumno][:rut]).first_or_create

    respond_to do |format|
      if @alumno.update_attributes(params[:alumno])
        profesion = Array.new
        if params[:alumno][:profesion] != nil && params[:alumno][:profesion].kind_of?(Array)
          params[:alumno][:profesion].each do |rubro|
            if rubro != ""
              profesion.push rubro
            end
          end
          @alumno.update_attributes(:profesion => profesion.to_json)
        end
        AlumnoCurso.where(:alumno_id => @alumno.id, :curso_id => params[:curso_id]).first_or_create
        if current_user.has_role? :relator
          format.html { redirect_to sesion_curso_path(params[:curso_id]) }
        else
          format.html { redirect_to curso_path(params[:curso_id]) }
        end
        format.json { render json: @alumno, status: :created, location: @alumno }
      else
        @curso = Curso.find(params[:curso_id])
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
      if @alumno.update_attributes(params[:alumno])
        profesion = Array.new
        if params[:alumno][:profesion] != nil && params[:alumno][:profesion].kind_of?(Array)
          @alumno.profesion.each do |rubro|
            if rubro != ""
              profesion.push rubro
            end
          end
          @alumno.update_attributes(:profesion => profesion.to_json)
        end
        if current_user.has_role? :relator
          format.html { redirect_to sesion_curso_path(params[:curso_id]) }
        else
          format.html { redirect_to curso_path(params[:curso_id]) }
        end
        format.json { head :no_content }
      else
        @curso = Curso.find(params[:curso_id])
        format.html { render action: "edit" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @alumno = Alumno.find(params[:id])
    @curso = Curso.find(params[:curso_id])
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    alumno = Alumno.find(params[:alumno_id])
    AlumnoCurso.where(:alumno_id => params[:alumno_id], :curso_id => params[:curso_id]).all.each do |alumno_curso|
      alumno_curso.destroy
    end
    alumno.sesiones_totales.each do |sesion|
      AlumnoSesion.where(:alumno_id => params[:alumno_id], :sesion_id => sesion).destroy_all
    end


    respond_to do |format|
      if current_user.has_role? :relator
        format.html { redirect_to sesion_curso_path(params[:curso_id]) }
      else
        format.html { redirect_to curso_path(params[:curso_id]) }
      end
      format.json { head :no_content }
    end
  end

  def delete_all
    @curso = Curso.find(params[:curso_id])
  end

  def destroy_all
    curso = Curso.find(params[:curso_id])
    curso.alumnos.each do |alumno|
      AlumnoCurso.where(:alumno_id => alumno, :curso_id => curso).all.each do |alumno_curso|
        alumno_curso.destroy
      end
      alumno.sesiones_totales.each do |sesion|
        AlumnoSesion.where(:alumno_id => alumno, :sesion_id => sesion).destroy_all
      end
    end

    respond_to do |format|
      if current_user.has_role? :relator
        format.html { redirect_to sesion_curso_path(params[:curso_id]) }
      else
        format.html { redirect_to curso_path(params[:curso_id]) }
      end
      format.json { head :no_content }
    end
  end

  # GET /alumnos/1/details
  # GET /alumnos/1/details.json
  def details
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      format.html # details.html.erb
      format.json { render json: @sesion }
    end
  end

  def import
    Alumno.import(params[:file], params[:curso_id])
    if current_user.has_role? :relator
      redirect_to sesion_curso_path(params[:curso_id])
    else
      redirect_to curso_path(params[:curso_id])
    end
  end

  def import_sence
    Alumno.import_sence(params[:file])
    redirect_to asistencia_curso_path(params[:curso_id])
  end

  def download_excel
    send_file("public/data/Excel Tipo.xlsx",
      :filename=> "Excel Tipo.xlsx",
      :type=>"application/xlsx",
      :x_sendfile=>true)
  end

  def asistencia
    alumno_sesion = AlumnoSesion.where(:alumno_id => params[:id], :sesion_id => params[:sesion]).first_or_create
    alumno_sesion.update_attributes(:presente => params[:presente])
    render :nothing => true
  end

  def search
    alumno = Alumno.where(:rut => params[:rut]).first
    if alumno
      AlumnoCurso.create(:alumno_id => alumno.id, :curso_id => params[:curso_id])
      redirect_to sesion_curso_path(params[:curso_id]), :notice => "Se agrego el alumno" + alumno.nombre
    else
      redirect_to sesion_curso_path(params[:curso_id]), :alert => "No se encontró el alumno con rut" + params[:rut]
    end
  end 
end
