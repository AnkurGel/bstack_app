require 'spec_helper'

describe 'HomePages' do

  describe 'Home Page' do
    before { visit root_path }
    subject { page }

    it { should have_selector('h1', text: 'BStack Uploader') }
    it { should have_title('BStack app') }

    describe 'for non-signed-in user' do
      describe 'menu listing' do
        it { should have_link('Home',   href: root_path) }
        it { should have_link('BStack', href: root_url) }
        it { should have_link('Login',  href: login_path) }
      end
    end

    describe 'for signed-in user' do
      describe 'menu listing' do
        let(:user) { FactoryGirl.create(:user) }
        before do 
          sign_in user
          visit root_path
        end

        it { should have_link('Upload file', href: file_upload_path) }
        it { should have_link('Sign out', href: logout_path) }
        it { should have_link('Upload New File', href: file_upload_path) }
        it { should have_link('Home', href: root_path) }
        it { should have_link('BStack', href: root_url) }
      end
    end

  end

end
