class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  validates :username, :password, :powerlevel, :active, presence: true
  validates :username, uniqueness: true
  validates :powerlevel, :active, numericality: { only_integer: true }
end
