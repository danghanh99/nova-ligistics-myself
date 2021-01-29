require 'rails_helper'

RSpec.describe Supplier, type: :model do
  before(:all) do
    Supplier.delete_all
    @user = FactoryBot.create(:supplier, phone: '1234567890')
    FactoryBot.create(:supplier, name: 'Le Dang Hanh', phone: '91011')
    FactoryBot.create(:supplier, name: 'Supper admin', phone: '5678')
    @supplier = FactoryBot.create(:supplier, name: 'Dang Hanh 99', phone: '1234')
  end

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

  describe 'search suppliers' do
    let!(:params_search) { { name: '' } }
    let!(:params_sort) { { sort: '' } }
    it 'should return total count equal 4 with search by name nil' do
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(4)
    end

    it 'should return total count equal 2 with search by name' do
      params_search[:name] = 'Dang Hanh'
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(2)
    end

    it 'should return total count equal 0 with search by name' do
      params_search[:name] = 'DANG HANH'
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(0)
    end

    it 'should return total count equal 3 with search by name' do
      params_search[:name] = 'H'
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(3)
    end

    it 'should return total count equal 1 with search by name' do
      params_search[:name] = 'Huy   '
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(1)
    end

    it 'should return total count equal 1 with search by name' do
      params_search[:name] = '    Huy   '
      suppliers = Supplier.search_by_filters(params_search)
      expect(suppliers.count).to eq(1)
    end

    it 'should return list descending by day with params sort' do
      suppliers = Supplier.search_by_filters(params_sort)
      expect(suppliers.first).to eq(@user)
    end

    it 'should return list asc by day with params sort' do
      params_sort[:sort] = 'ASC'
      suppliers = Supplier.search_by_filters(params_sort)
      expect(suppliers.first).to eq(@user)
    end

    it 'should return list asc by day with params sort' do
      params_sort[:sort] = 'ASC  '
      suppliers = Supplier.search_by_filters(params_sort)
      expect(suppliers.first).to eq(@user)
    end

    it 'should return list desc by day with params sort' do
      params_sort[:sort] = 'Desc'
      suppliers = Supplier.search_by_filters(params_sort)
      expect(suppliers.first).to eq(@supplier)
    end

    it 'should return list desc by day with params sort' do
      params_sort[:sort] = 'DESC  '
      suppliers = Supplier.search_by_filters(params_sort)
      expect(suppliers.first).to eq(@supplier)
    end
  end
end
