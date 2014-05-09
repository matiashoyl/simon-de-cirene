class FormularioCurso < ActiveRecord::Base
  attr_accessible :curso_id, :estado, :formulario_id, :duplicates, :contestados

  def contestado?
  	if self.estado == "Contestado"
  		return true
  	else
  		return false
  	end
  end

  def pendientes
  	return (self.duplicates - self.contestados)
  end
end
