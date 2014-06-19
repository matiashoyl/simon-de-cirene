class ProgramasController < ApplicationController
  respond_to :html, :js
  # GET /programas
  # GET /programas.json
  def index
    @programas = Programa.all_active
    @programa = Programa.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programas }
    end
  end

  def index_inactivos
    @programas = Programa.where(:active => false).all
  end

  # GET /programas/1
  # GET /programas/1.json
  def show
    @programa = Programa.find(params[:id])
    @programas_sociales = Programa.where(:tipo => "Social", :active => true).all
    @programas_microempresas = Programa.where(:tipo => "Microempresas", :active => true).all
    @curso = Curso.new
    @cursos = @programa.cursos.where(:active => true).order(:created_at).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @programa }
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @programa.nombre + '.xls"'
        render "show.xls.erb"
      end
    end
  end

  def show_inactivos
    @programa = Programa.find(params[:id])
    @programas_sociales = Programa.where(:tipo => "Social", :active => false).all
    @programas_microempresas = Programa.where(:tipo => "Microempresas", :active => false).all
    @curso = Curso.new
    @cursos = @programa.cursos.where(:active => false).order(:created_at).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @programa }
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @programa.nombre + '.xls"'
        render "show.xls.erb"
      end
    end
  end

  # GET /programas/new
  # GET /programas/new.json
  def new
    @programa = Programa.new
  end

  # GET /programas/1/edit
  def edit
    @programa = Programa.find(params[:id])
    session[:return_to] ||= request.referer
  end

  # POST /programas
  # POST /programas.json
  def create
    @programa = Programa.new(params[:programa])

    respond_to do |format|
      if @programa.save
        format.html { redirect_to programas_path }
        format.json { render json: @programa, status: :created, location: @programa }
      else
        format.html { render action: "new" }
        format.json { render json: @programa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programas/1
  # PUT /programas/1.json
  def update
    @programa = Programa.find(params[:id])

    respond_to do |format|
      if @programa.update_attributes(params[:programa])
        format.html { redirect_to session.delete(:return_to) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @programa.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @programa = Programa.find(params[:id])
  end

  # DELETE /programas/1
  # DELETE /programas/1.json
  def destroy
    @programa = Programa.find(params[:id])
    @programa.cursos.each do |curso|
      curso.destroy
    end
    @programa.destroy

    respond_to do |format|
      format.html { redirect_to programas_url }
      format.json { head :no_content }
    end
  end

  def set_active
    ###### Programas ######
    programa = Programa.find(params[:id])
    programa.update_attributes(:active => params[:active])

    ###### Cursos ######
    programa.cursos.each do |curso|
      curso.update_attributes(:active => params[:active])
      ###### Sesiones ######
      curso.sesions.each do |sesion|
        sesion.update_attributes(:active => params[:active])
      end
    end
    render :nothing => true
  end

  
end
