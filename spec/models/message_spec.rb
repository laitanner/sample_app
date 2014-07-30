require 'spec_helper'

describe Message do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:message){ user1.sent_messages.build(content: "Lorem ipsum", addresser_id: user1.id, addressee_id: user2.id) }
  
  subject { message }

  it { should respond_to(:content) }
  it { should respond_to(:addresser_id) }
  it { should respond_to(:addressee_id) }
  its(:addresser) { should eq user1 }

  it { should be_valid }

  describe "when addresser is not present" do
    before { message.addresser = nil }
    it { should_not be_valid }
  end

  describe "when addressee is not present" do
    before { message.addressee = nil }
    it { should_not be_valid }
  end
end