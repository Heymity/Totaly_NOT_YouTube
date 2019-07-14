class Video < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  #before_create :define_video!
  validates_presence_of :video_text, :user_id
  
  def info
    "#{video_text} - #{created_at} - #{description}" 
  end

  #def define_video!
  #  begin
  #    self.video_text = "asdasds"
  #  end #while Video.exists?(video_text: video_text)
  #end

end
