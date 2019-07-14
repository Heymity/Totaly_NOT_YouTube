class User < ApplicationRecord
               
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  include DeviseTokenAuth::Concerns::User

  validates_uniqueness_of :auth_token
  before_create :generate_authentication_token!
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy

  def info
    "#{email} - #{created_at} - #{Devise.friendly_token}" 
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while User.exists?(auth_token: auth_token)
  end

end
