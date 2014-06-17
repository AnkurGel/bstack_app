require 'spec_helper'

describe Upload do
  before { @file = FactoryGirl.build(:upload) }
  subject { @file }

  it { should be_valid }
  it { should respond_to :name }
  it { should respond_to :path }
  it { should respond_to :size }
  it { should respond_to :content_type }
  it { should respond_to :user_id }

  describe "when saved must process the elements" do
    before { @file.save }

    its(:name) { should match(/factories.*/) }
    its(:size) { should > 0 }
    its(:path) { should match(/factories/) }
    its(:user) { should == User.first }
  end

  describe "when saved" do
    before { @file.save }

    it "must save the file" do
      File.exists?(@file.path).should be_true
    end
  end
  
  describe "when destroyed" do
    before { @file.save }

    it "must delete the file too" do
      path = @file.path
      @file.destroy
      File.exists?(path).should be_false
    end
  end

end
