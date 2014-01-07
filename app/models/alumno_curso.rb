class AlumnoCurso < ActiveRecord::Base
  audited

  attr_accessible :alumno_id, :curso_id

  validates :alumno_id, :curso_id, :presence => true
  
end
