require 'spec_helper'

describe Message do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@message = user.messages.build(title: 'Hello', description: 'first message', user_id: user.id)
  end
  
  subject{ @message }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  
  its(:user) { should eq user }

  describe "when user_id is not present" do
    before { @message.user_id = nil }
    it { should_not be_valid }
  end

end
