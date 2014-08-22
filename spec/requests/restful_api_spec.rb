require 'spec_helper'

describe "RESTful API" do 
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user, no_capybara: true }

  describe "creating a micropost by POST request" do

  	it "should increment the micropost count" do
  	  expect do
      	post microposts_path, micropost: { content: "Lorem ipsum" }, format: :xml
      end.to change(Micropost, :count).by(1)
  	end

  	it "should respond with success" do
  	  post microposts_path, micropost: { content: "Lorem ipsum" }, format: :xml
  	  expect(response).to be_success
  	end

  end

  describe "destroying a micropost by DELETE request" do
  	let!(:micropost) { FactoryGirl.create(:micropost, user: user) }

  	it "should decrement the Micropost count" do
  	  expect do
  	  	delete micropost_path(micropost.id), format: :xml 
  	  end.to change(Micropost, :count).by(-1)
  	end

  	it "should respond with success" do
  	  delete micropost_path(micropost.id), format: :xml
  	  expect(response).to be_success
  	end
  end
	
end