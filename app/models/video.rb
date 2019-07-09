class Video < ApplicationRecord
  belongs_to :user

  validates_presence_of :video_text, :user_id
  
end
