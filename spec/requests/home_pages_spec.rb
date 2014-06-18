require 'spec_helper'

describe 'HomePages' do

  describe 'Home Page' do
    before { visit root_path }
    let(:user) { FactoryGirl.create :user }
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
        before do 
          sign_in user
          visit root_path
        end

        it { should have_link('Upload file',     href: file_upload_path) }
        it { should have_link('Sign out',        href: logout_path) }
        it { should have_link('Upload New File', href: file_upload_path) }
        it { should have_link('Home',            href: root_path) }
        it { should have_link('BStack',          href: root_url) }
      end

      describe 'when his upload exist' do
        let(:file) { FactoryGirl.create :upload }
        before do
          sign_in file.user
          visit root_path
        end

        it 'should list the file' do
          should have_selector('th', text: 'Sno')
          should have_selector('th', text: 'Filename')
          should have_selector('th', text: 'Uploaded On')
          should have_selector('th', text: 'Download')
          should have_selector('th', text: 'Remove')


          should have_selector('td', text: '1')
          should have_selector('td', text: 'factories')
        end

        it 'should show the option to Download the file' do
          should have_link('Download', href: download_upload_path(file))
        end

        it 'should show the option to Remove the file' do
          should have_selector('a', text: 'Delete')
        end


        describe 'when clicks on Delete Link' do
          before do
            click_link 'Delete'
          end

          it { should_not have_selector('th', text: 'Filename') }
          it { should_not have_selector('td', text: 'factories') }
        end
      end
    end

  end

end
