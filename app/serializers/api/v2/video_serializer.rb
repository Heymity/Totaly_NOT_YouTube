class Api::V2::VideoSerializer < ActiveModel::Serializer
  attributes :id, :video_text, :description, :date, :user_id, :created_at, :updated_at, :is_ready

  def is_ready
    Date.current > object.date if object.date.present?
  end

  belongs_to :user, class_name: "user", foreign_key: "user_id"
end
