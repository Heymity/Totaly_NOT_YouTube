require 'rails_helper'

RSpec.describe Comment, type: :model do

    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to allow_value("123456$%^&*()").for(:description) }
  
  #pending "add some examples to (or delete) #{__FILE__}"
end
