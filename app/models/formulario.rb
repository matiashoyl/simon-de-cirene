class Formulario < ActiveRecord::Base
  attr_accessible :codigo, :url, :nombre, :tipo

  validates :codigo, :url, :nombre, :tipo, :presence => true
  validates :codigo, :uniqueness => true

  def estado(curso)
  	return FormularioCurso.where(:formulario_id => self, :curso_id => curso).first.estado
  end

  def contestado?(curso)
  	if FormularioCurso.where(:formulario_id => self, :curso_id => curso).first.estado == "Contestado"
  		return true
  	else
  		return false
  	end
  end

  def cursos_ids
    cursos = Array.new
    curso_ids = FormularioCurso.where(:formulario_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
    curso_ids.each do |curso_id|
      cursos.push curso_id
    end
    return cursos
  end

  def eliminar_cursos
    curso_ids = FormularioCurso.where(:formulario_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
    curso_ids.each do |curso_id|
      FormularioCurso.where(:formulario_id => self, :curso_id => curso_id).destroy_all
    end
  end
end
