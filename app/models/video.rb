class Video < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  validates_presence_of :video_text, :user_id
  
end
