class AlumnoSesion < ActiveRecord::Base
  attr_accessible :alumno_id, :sesion_id, :presente

  validates :alumno_id, :sesion_id, :presence => true
  validates :presente, :inclusion => {:in => [true, false]}
end
