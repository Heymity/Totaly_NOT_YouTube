require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { build(:user) } 
  let(:video) { build(:video) }
  let(:comment) { build(:comment) }

    #it { is_expected.to validate_presence_of(:user_id) }
    #it { is_expected.to validate_presence_of(:video_id) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to allow_value("123456$%^&*()").for(:description) }
  
  
end
