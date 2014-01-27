require 'spec_helper'

describe "UsersPages" do
  subject{page}

  describe "sign up page" do
  	before {visit signup_path}

  	it {should have_title(" Sign Up ")}
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do

    before { visit signup_path }

    let(:submit) { "Create Me" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Oleg"
        fill_in "Email",        with: "o.motenko@mail.ru"
        fill_in "Password",     with: "omotenko"
        fill_in "Confirmation", with: "omotenko"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end  
  end  
end
