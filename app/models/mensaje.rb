class Mensaje < ActiveRecord::Base
	attr_accessible :caracter, :cuerpo, :titulo
	validates :cuerpo, :titulo, :presence => true

	def receptores_ids
		receptores = Array.new
		receptores_ids = MensajeUsuario.where(:mensaje_id => self).select(:usuario_id).group(:usuario_id).collect{|p| p.usuario_id}
		receptores_ids.each do |receptor_id|
			receptores.push receptor_id.to_s
		end
		return receptores
	end

	def receptores_string
		receptores = ""
		receptores_ids = MensajeUsuario.where(:mensaje_id => self).select(:usuario_id).group(:usuario_id).collect{|p| p.usuario_id}
		receptores_ids.each do |receptor_id|
			receptores += User.find(receptor_id).name + ", "
		end
		return receptores[0..(receptores.length - 3)]
	end

	def eliminar_receptores
		receptores_ids = MensajeUsuario.where(:mensaje_id => self).select(:usuario_id).group(:usuario_id).collect{|p| p.usuario_id}
		receptores_ids.each do |receptor_id|
			MensajeUsuario.where(:mensaje_id => self, :usuario_id => receptor_id).destroy_all
		end
	end
end
