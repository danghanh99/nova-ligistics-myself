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
  end
end
