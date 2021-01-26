require 'rails_helper'

RSpec.describe Suplier, type: :model do
  describe 'name' do
    it { should respond_to(:name) }
    it { should allow_value('Suplier').for(:name) }
    it { should_not allow_value(' ').for(:name) }
    it { should_not allow_value(nil).for(:name) }
    it { should_not allow_value('a').for(:name) }
    it 'should be greater or equal 2 and less than or equal 20' do
      should validate_length_of(:name).is_at_least(2).is_at_most(40)
    end
    it 'should presence' do
      should validate_presence_of(:name)
    end
  end

  describe 'phone' do
    it { should respond_to(:phone) }
    it { should allow_value('123456789').for(:phone) }
    it { should_not allow_value('12345678900987654321123456').for(:phone) }
    it 'should lenght less than or equal 25' do
      should validate_length_of(:phone).is_at_most(25)
    end
    it { should allow_value(nil).for(:phone) }
  end

  describe 'address' do
    it { should respond_to(:address) }
    it { should allow_value('address').for(:address) }
  end

  describe 'notes' do
    it { should respond_to(:notes) }
    it { should allow_value('notes').for(:notes) }
  end
end
