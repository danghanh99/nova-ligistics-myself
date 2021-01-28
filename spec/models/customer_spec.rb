require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'name' do
    it { should respond_to(:name) }
    it { should allow_value('novahub').for(:name) }
    it { should_not allow_value('a' * 129).for(:name) }
    it { should_not allow_value(nil).for(:name) }
    it { should_not allow_value(' ').for(:name) }
    it { should_not allow_value('  ').for(:name) }
  end

  describe 'address' do
    it { should respond_to(:address) }
    it { should allow_value('10b, nguyen chi thanh, thach thanh, hai chau, da nang').for(:address) }
    it { should_not allow_value('').for(:address) }
  end

  describe 'phone_number' do
    it { should respond_to(:phone_number) }
    it { should allow_value('02363689911').for(:phone_number) }
    it { should_not allow_value('').for(:phone_number) }
    it { should_not allow_value('invalid phone number').for(:phone_number) }
    it { should_not allow_value('-1').for(:phone_number) }
    it { should_not allow_value('1.1').for(:phone_number) }
  end
end
