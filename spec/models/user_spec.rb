require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }

    before :all do
      @user = User.create(
        first_name: 'Billy Joe',
        last_name: 'Bobby',
        email: 'bjb@bobby.ca',
        password: 'forksforks',
        password_confirmation: 'forksforks'
      )
      @user2 = User.create(
        first_name: 'Bobby Joe',
        last_name: 'Billman',
        email: 'bjb@billymanny.edu',
        password: 'spoonsspoons',
        password_confirmation: 'knivesknives'
      )
      @user3 = User.create(
        first_name: 'Benny James',
        last_name: 'Bobby',
        email: 'BJB@bobby.ca',
        password: 'sporkssporks',
        password_confirmation: 'sporkssporks'
      )
      @user4 = User.create(
        first_name: 'Charlie',
        last_name: 'Chuckster',
        email: 'charchuck@ster.co',
        password: 'tongs',
        password_confirmation: 'tongs'
      )
    end

    it 'should validate that password and password_confirmation match' do
      expect(@user.valid?).to eql(true)
      expect(@user2.valid?).to eql(false)
    end

    it 'should validate uniqueness of emails with case insensitivity' do
      expect(@user3.valid?).to eql(false)
    end

    it 'should validate minimum length of password' do
      expect(@user4.valid?).to eql(false)
    end
  end

  describe '.authenticate_with_credentials' do
    before :all do
      @user = User.create(
        first_name: 'Billy Joe',
        last_name: 'Bobby',
        email: 'bjb@bobby.ca',
        password: 'forksforks',
        password_confirmation: 'forksforks'
      )
    end

    it 'should authenticate' do
      login = User.authenticate_with_credentials('bjb@bobby.ca', 'forksforks')
      expect(login).to be_truthy
    end

    it 'should authenticate when uppercase email' do
      login = User.authenticate_with_credentials('BJB@bobby.ca', 'forksforks')
      expect(login).to be_truthy
    end

    it 'should not authenticate when password is incorrect' do
      login = User.authenticate_with_credentials('bjb@bobby.ca', 'forksfork')
      expect(login).to be_falsey
    end

    it 'should authenticate with case-sensitve password' do
      login = User.authenticate_with_credentials('bjb@bobby.ca', 'FORKSFORKS')
      expect(login).to be_falsey
    end

    it 'should authenticate when email has leading/trailing spaces' do
      login = User.authenticate_with_credentials(' bjb@bobby.ca ', 'forksforks')
      expect(login).to be_truthy
    end
  end
end
