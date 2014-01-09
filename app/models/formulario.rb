class Formulario < ActiveRecord::Base
  attr_accessible :codigo, :cuerpo, :nombre, :tipo

  validates :codigo, :cuerpo, :nombre, :tipo, :presence => true
end
