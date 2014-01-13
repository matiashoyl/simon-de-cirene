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
end
