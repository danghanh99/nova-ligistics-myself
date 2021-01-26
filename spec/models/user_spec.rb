require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email' do
    it { should respond_to(:email) }
    it { should allow_value('admin@gmail.com').for(:email) }
    it { should allow_value('Admin@Gmail.com').for(:email) }
    it { should allow_value('ADMIN@GMAIL.COM').for(:email) }
    it { should_not allow_value('admin@').for(:email) }
    it { should_not allow_value('admin@admin@gmail.com').for(:email) }
    it { should_not allow_value('#@%^%#$@#$@#.com').for(:email) }
    it { should_not allow_value('invalidgmailcom').for(:email) }
    it { should_not allow_value('&#12354;&#12356;&#12358;&#12360;&#12362;@domain.com').for(:email) }
    it { should_not allow_value('email@domain.com (Joe Smith)').for(:email) }
    it { should_not allow_value('email@gmail.com (Joe Smith)').for(:email) }
    it { should_not allow_value('email@domain').for(:email) }
    it { should_not allow_value('email@111.222.333.44444').for(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe User do
    it { should have_many(:imports) }
    it { should have_many(:exports) }
  end

  describe 'phone' do
    it { should respond_to(:phone) }
    it { should allow_value('123456789').for(:phone) }
    it { should_not allow_value('12345678900987654321123456').for(:phone) }
    it 'should lenght less than or equal 25' do
      should validate_length_of(:phone).is_at_most(25)
    end
    it { should allow_value(nil).for(:phone) }
    it { should validate_uniqueness_of(:phone) }
  end

  describe 'encrypt password' do
    let!(:password) { '123456' }
    let!(:password_salt) { BCrypt::Engine.generate_salt }
    it 'should after encoding when encoding with original ' do
      encrypted_password = User.generate_encrypted_password(password, password_salt)
      expect(encrypted_password).to eq(User.generate_encrypted_password('123456', encrypted_password.first(29)))
    end
  end
end
