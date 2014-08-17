require 'spec_helper'

describe Message do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:message){ user1.messages.build(content: "Lorem ipsum", addressee_id: user2.id) }
  
  subject { message }

  it { should respond_to(:content) }
  it { should respond_to(:addressee_id) }
  its(:user) { should eq user1 }

  it { should be_valid }

  describe "when addressee_id is not present" do
    before { message.addressee_id = nil }
    it { should_not be_valid }
  end
end