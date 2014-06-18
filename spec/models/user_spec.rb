require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build :user 
  end

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :encrypted_password }
  it { should respond_to :uploads }

  it { should be_valid }

  describe "when name is missing" do
    before { @user.name = '' }
    it { should_not be_valid }
  end

  describe "when email is missing" do
    before { @user.email = '' }
    it { should_not be_valid }
  end

  describe "when password is missing" do
    before do 
      @user.password = '' 
      @user.password_confirmation = ''
    end
    it { should_not be_valid }
  end

  describe "when confirmation password is missing" do
    before { @user.password_confirmation = '' }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = 'a' * 61 }
    it { should_not be_valid }
  end

  describe "when email has wrong format" do
    it "should not be valid" do
      invalid_addresses = %w(ankur@foo,com ankur@foo ankur_at_foo.com)
      invalid_addresses.each do |invalid|
        @user.email = invalid
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is correct" do
    it "should be valid" do
      %w[ankur@ankurgoel.com Ankur@ankurgoel.com].each do |addr|
        @user.email = addr
        @user.should be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      # duplicate all attrs other than id and timestamps
      other_user = @user.dup
      other_user.save
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match it's confirmation" do
    before { @user.password_confirmation = 'wrongpass' }
    it { should_not be_valid }
  end

  describe "when password is less than 6 char" do
    before { @user.password = @user.password_confirmation = 'foo' }
    it { should_not be_valid }
  end

end

