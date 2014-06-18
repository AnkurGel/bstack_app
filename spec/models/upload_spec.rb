require 'spec_helper'

describe Upload do
  before { @file = FactoryGirl.build(:upload) }
  subject { @file }

  it { should be_valid }
  it { should respond_to :file }

  describe "when saved must process the elements" do
    before { @file.save }

    its('file.file.original_filename') { should match(/factories.*/) }
    its('file.size') { should > 0 }
    its('file.path') { should match(/factories/) }
    its(:user) { should == User.first }
  end

  describe "when saved" do
    before { @file.save }

    it "must save the file" do
      File.exists?(@file.file.path).should be_true
    end
  end
  
  describe "when destroyed" do
    before { @file.save }

    it "must delete the file too" do
      path = @file.file.path
      @file.destroy
      File.exists?(path).should be_false
    end
  end

end
