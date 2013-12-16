class Curso < ActiveRecord::Base
  attr_accessible :codigo, :fecha_inicio, :fecha_termino, :nombre
end
