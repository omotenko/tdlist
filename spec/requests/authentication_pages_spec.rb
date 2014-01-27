require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}

  describe "sign in page" do
    before {visit signin_path}
  	it {should have_title(" | Sign in ")}
  end

  describe "signin" do 
  	before {visit signin_path}

  	describe "with valid information" do
  		let(:user) {FactoryGirl.create(:user)}
  		before do
  			fill_in "Email",     with: user.email
  			fill_in "Password",  with: user.password
  			click_button "Sign in"
  		end

  	  it { should have_title(user.name) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
  	end
  end
end
