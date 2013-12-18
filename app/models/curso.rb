class Curso < ActiveRecord::Base
	has_many :sesions
	has_many :users, :through => :sesions

	attr_accessible :codigo, :nombre, :comuna 

	validates :codigo, :nombre, :comuna, :presence => true
	validates :codigo, :uniqueness => true
end
