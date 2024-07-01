class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :comments
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :registerable
end
