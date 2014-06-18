require 'spec_helper'

describe 'AuthPages' do

  describe 'SignUp page' do
    before { visit signup_path }
    subject { page }

    # has_field? can search by label/id/name
    it { should have_field('Name') }
    it { should have_field('Email') }
    it { should have_field('Password') }
    it { should have_field('Password confirmation') }

    describe 'when filled with invalid information' do
      before do
        fill_in 'Name',     with: 'Ankur Goel'
        fill_in 'Email',    with: 'ankur_at_gmail_dot_com'
        fill_in 'Password', with: 'wut'
        fill_in 'Password confirmation', with: 'woah'
        click_button 'Sign Up'
      end
      it { should have_content("Password confirmation doesn't match Password") }
      it { should have_content("Email is invalid") }
      it { should have_content('Password is too short (minimum is 6 characters)') }
    end

    describe 'when filled with valid information' do
      before do
        fill_in 'Name',     with: 'Ankur Goel'
        fill_in 'Email',    with: 'Ankur@ankurgoel.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Password confirmation', with: 'foobar'
        click_button 'Sign Up'
      end

      it { should have_content('Welcome onboard, Ankur Goel') }
      it { should have_content('Upload File') }
      it { should have_button('Upload Now') }
      it { should have_content('Sign out') }
    end
  end

end
