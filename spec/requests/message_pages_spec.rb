require 'spec_helper'

describe "Message pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  before do 
    sign_in user
  end

  describe "message creation" do
    before { visit root_path }

    describe "creating a message from the micropost text box" do
      
      before { fill_in 'micropost_content', with: "d#{user2.id}-example-user" }

      it "should create a message" do
        expect { click_button "Post" }.to change(Message, :count).by(1)
      end

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "that is addressed to the user themselves" do
        before { fill_in 'micropost_content', with: "d#{user.id}-example-user" }

        it "should not create a message" do
          expect { click_button "Post" }.to change(Message, :count).by(0)
        end
      end
    end
  end
end
