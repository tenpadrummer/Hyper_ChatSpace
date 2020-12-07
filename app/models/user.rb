class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :messages, dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i.freeze
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: { case_sensitive: true }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, format: { with: PASSWORD_REGEX }
end
