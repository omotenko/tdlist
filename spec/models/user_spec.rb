require 'spec_helper'

describe User do

  before do @user = User.new(name: "Oleg", email: "o.motenko@mail.ru", 
  					password: "Moten1992ol", password_confirmation: 'Moten1992ol')
  end

  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:remember_token)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:messages)}
  it {should be_valid}

  describe "when name is not present" do
  	before {@user.name = ""}

  	it {should_not be_valid}
  end

  describe "when email is not present" do
  	before {@user.email = ""}

  	it {should_not be_valid}
  end

  describe "when name is too long" do
  	before {@user.name = "m" * 31}

  	it {should_not be_valid}
  end

  describe "when email is invalid" do
  	it "should be invalid" do
  		address = %w[oleg.motenko,com oleg@motenko oleg.motenko@mail. oleg.motenko.@.ru o.m-@-.ru]
  		address.each do |invalid_address|
  			@user.email = invalid_address
  			should_not be_valid
  		end
  	end
  end

  describe "when email is valid" do
  	it "should be valid" do
 		address = %w[o.motenko@mail.ru o.motenko.alx@ya.com.ua]
  		address.each do |valid_address|
  			@user.email = valid_address
  			should be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end
  	it {should_not be_valid} 
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
    before {@user.password_confirmation = "wrong_password"}
    it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
    before {@user.password_confirmation = nil}
    it {should_not be_valid}
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:user_for_valid_password) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq user_for_valid_password.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { user_for_valid_password.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "messages" do

    before { @user.save }
    let!(:old_message) do
      FactoryGirl.create(:message, user: @user, created_at: 2.hours.ago)
    end
    let!(:new_message) do
      FactoryGirl.create(:message, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right messages in the right order" do
      expect(@user.messages.to_a).to eq [new_message, old_message]
    end

    it "should destroy messages" do
      messages = @user.messages.to_a
      @user.destroy
      expect(messages).not_to be_empty
      messages.each do |message|
        expect(Message.where(id: message.id)).to be_empty
      end
    end
  end

end
