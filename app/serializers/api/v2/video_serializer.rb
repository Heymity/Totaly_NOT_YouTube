class Api::V2::VideoSerializer < ActiveModel::Serializer
  attributes :id, :video_text, :description, :date, :user_id, :created_at, :updated_at, :is_ready#, :date_to_br

  def is_ready
    begin
      Date.current > object.date #if object.date.present?
    rescue
      return true
  
    end
  end

  #def date_to_br
  #  I18n.l(object.date, format: :databr) if object.date.present?
  #end
  
  belongs_to :user, class_name: "user", foreign_key: "user_id"
end
