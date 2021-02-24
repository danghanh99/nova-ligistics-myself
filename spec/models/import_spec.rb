require 'rails_helper'

RSpec.describe Import, type: :model do
  describe 'retail_price' do
    it { should respond_to(:retail_price) }
    it { should allow_value(123).for(:retail_price) }
    it { should_not allow_value(-123).for(:retail_price) }
    it { should allow_value(0).for(:retail_price) }
    it 'should presence' do
      should validate_presence_of(:retail_price)
    end
  end

  describe 'quantity' do
    it { should respond_to(:quantity) }
    it { should allow_value(123).for(:quantity) }
    it { should_not allow_value(-123).for(:quantity) }
    it { should allow_value(0).for(:quantity) }
    it 'should presence' do
      should validate_presence_of(:quantity)
    end
    it { should_not allow_value(1.1).for(:quantity) }
  end

  describe Import do
    it { should belong_to(:supplier).optional }
    it { should belong_to(:user) }
    it { should belong_to(:inventory) }
    it { should belong_to(:product) }
    it { should have_many(:exports) }
  end
end
