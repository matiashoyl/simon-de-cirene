class Sesion < ActiveRecord::Base
	belongs_to :curso
	has_many :users

 	attr_accessible :comentario, :direccion, :fecha, :hora_inicio, :hora_termino, :tema, :tipo

 	validates :tema, :tipo, :direccion, :fecha, :hora_inicio, :hora_termino, :presence => true
end
