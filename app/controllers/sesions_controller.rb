class SesionsController < ApplicationController
  # GET /sesions
  # GET /sesions.json
  def index
    @sesion = Sesion.new
    curso_ids = Sesion.where(:user_id => current_user).group(:curso_id).collect{|p| p.curso_id}
    @cursos = Array.new
    curso_ids.each do |curso_id|
      curso = Curso.find(curso_id)
      @cursos.push curso
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sesions }
    end
  end

  # GET /sesions/1
  # GET /sesions/1.json
  def show
    @sesion = Sesion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sesion }
    end
  end

  # GET /sesions/new
  # GET /sesions/new.json
  def new
    @sesion = Sesion.new
    @curso_id = params[:curso_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sesion }
    end
  end

  # GET /sesions/1/edit
  def edit
    @sesion = Sesion.find(params[:id])
  end

  # POST /sesions
  # POST /sesions.json
  def create
    @sesion = Sesion.new(params[:sesion])

    respond_to do |format|
      if @sesion.save
        if current_user.has_role? :relator
          format.html { redirect_to sesions_path }
        else
          format.html { redirect_to curso_path(@sesion.curso_id) }
        end
        format.json { render json: @sesion, status: :created, location: @sesion }
      else
        format.html { render action: "new" }
        format.json { render json: @sesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sesions/1
  # PUT /sesions/1.json
  def update
    @sesion = Sesion.find(params[:id])

    respond_to do |format|
      if @sesion.update_attributes(params[:sesion])
        format.html { redirect_to @sesion, notice: 'Sesion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sesion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sesions/1
  # DELETE /sesions/1.json
  def destroy
    @sesion = Sesion.find(params[:id])
    @sesion.destroy

    respond_to do |format|
      format.html { redirect_to curso_path(@sesion.curso_id) }
      format.json { head :no_content }
    end
  end
end
