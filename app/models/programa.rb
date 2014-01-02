class Programa < ActiveRecord::Base
	has_many :cursos
	has_many :sesions, :through => :cursos

  	attr_accessible :nombre, :tipo

  	validates :nombre, :tipo, :presence => true
  	validates :tipo, :inclusion => {:in => ["Social", "Microempresas"]}
end
