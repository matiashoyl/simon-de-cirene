class AlumnoSesion < ActiveRecord::Base
  attr_accessible :alumno_id, :sesion_id

  validates :alumno_id, :sesion_id, :presence => true
end
