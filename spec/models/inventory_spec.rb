require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'name' do
    it { should respond_to(:name) }
    it { should allow_value('ADMIN').for(:name) }
    it { should_not allow_value(' ').for(:name) }
  end

  describe 'address' do
    it { should respond_to(:address) }
    it { should allow_value('street_address').for(:address) }
    it { should allow_value(' ').for(:address) }
    it { should allow_value(nil).for(:address) }
  end

  describe Inventory do
    it { should have_many(:imports) }
    it { should have_many(:exports) }
  end
end
