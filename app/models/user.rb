class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  has_many :sesion
  audited

  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :role_ids, :password, :password_confirmation, :remember_me

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  
  def mensajes
    mensajes = Array.new
    mensajes_ids = MensajeUsuario.where(:usuario_id => self).select(:mensaje_id).group(:mensaje_id).collect{|p| p.mensaje_id}
    mensajes_ids.each do |mensaje_id|
      mensaje = Mensaje.find(mensaje_id)
      mensajes.push mensaje
    end
    return mensajes.sort {|a,b| b.created_at <=> a.created_at}
  end

  def cursos
    if self.has_role? :relator
      cursos = Array.new
      Curso.where(:relator_jefe_id => self).each do |curso|
        cursos.push curso
      end
      return cursos
    else
      return nil
    end
    
  end
end
