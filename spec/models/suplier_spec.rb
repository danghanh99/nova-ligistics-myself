require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'name' do
    it { should respond_to(:name) }
    it { should allow_value('Supplier').for(:name) }
    it { should_not allow_value(' ').for(:name) }
    it { should_not allow_value(nil).for(:name) }
    it { should_not allow_value('a').for(:name) }
    it 'should be greater or equal 2 and less than or equal 255' do
      should validate_length_of(:name).is_at_least(2).is_at_most(255)
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
    it { should validate_uniqueness_of(:phone).case_insensitive }
  end

  describe 'address' do
    it { should respond_to(:address) }
    it { should allow_value('address').for(:address) }
  end

  describe 'description' do
    it { should respond_to(:description) }
    it { should allow_value('description').for(:description) }
  end

  describe Supplier do
    it { should have_many(:imports) }
  end
end
