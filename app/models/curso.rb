class Curso < ActiveRecord::Base
	belongs_to :programa
	has_many :sesions
	has_many :users, :through => :sesions

	attr_accessible :codigo, :nombre, :comuna, :programa_id

	validates :codigo, :nombre, :comuna, :programa_id, :presence => true
	validates :codigo, :uniqueness => true
end
