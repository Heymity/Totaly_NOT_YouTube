require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { build(:user) } 

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) } 
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to allow_value("teste@supergeeks.com").for(:email) }
    it { is_expected.to allow_value("123456$%^&*()").for(:password) }
    it { is_expected.to validate_uniqueness_of(:auth_token) }
end
