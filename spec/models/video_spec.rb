require 'rails_helper'

RSpec.describe Video, type: :model do
  #let(:user) { build(:user) } 
  let(:video) { build(:video) }

  #it { is_expected.to validate_presence_of(:video) }
  it { is_expected.to validate_presence_of(:video_text) }
  it { is_expected.to allow_value("Titulo").for(:title) }
  it { is_expected.to allow_value("123456$%^&*()").for(:video_text) }
end
