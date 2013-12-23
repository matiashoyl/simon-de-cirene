class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  has_many :sesion

  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :role_ids, :password, :password_confirmation, :remember_me
  
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  
end
