class Sesion < ActiveRecord::Base
	belongs_to :curso
	belongs_to :user

 	attr_accessible :comentario, :direccion, :fecha, :hora_inicio, :hora_termino, :tema, :tipo, :curso_id, :user_id

 	validates :tema, :tipo, :direccion, :fecha, :hora_inicio, :hora_termino, :curso_id, :user_id, :presence => true
end
