require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'name' do
    it { should respond_to(:name) }
    it { should allow_value('pen').for(:name) }
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

  describe 'description' do
    it { should respond_to(:description) }
    it { should allow_value('description').for(:description) }
    it { should allow_value(nil).for(:description) }
    it 'should have length shorter than or equal to 225' do
      should validate_length_of(:description).is_at_most(225)
    end
  end

  describe 'sku' do
    it { should respond_to(:sku) }
    it { should allow_value(' ').for(:sku) }
    it { should allow_value(nil).for(:sku) }
    it { should validate_uniqueness_of(:sku) }
  end
end
