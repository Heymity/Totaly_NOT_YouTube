class Api::V2::CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :updated_at

  belongs_to :user, class_name: "user", foreign_key: "user_id"
  belongs_to :video, class_name: "video", foreign_key: "video_id" 

end
