require 'rails_helper'

RSpec.describe Export, type: :model do
  describe 'sell_price' do
    it { should respond_to(:sell_price) }
    it { should allow_value(123).for(:sell_price) }
    it { should_not allow_value(-123).for(:sell_price) }
    it { should allow_value(0).for(:sell_price) }
    it 'should presence' do
      should validate_presence_of(:sell_price)
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
  end

  describe Export do
    it { should belong_to(:user) }
    it { should belong_to(:inventory) }
    it { should belong_to(:import) }
  end
end
