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

  describe "getting all users with index action" do
  	let!(:other_user) { FactoryGirl.create(:user) }
  	before { get users_path, format: 'xml' }

  	it "should have the right number of users" do
  	  users = Hash.from_xml(response.body)['users']
  	  assert_equal users.length, 2, "Number of users was not correct"
  	end

  	it "should respond with actual users" do
  	  users = Hash.from_xml(response.body)['users']

  	  assert_equal users.first['id'], user.id
  	  assert_equal users.first['email'], user.email
  	  assert_equal users.first['name'], user.name

  	  assert_equal users.last['id'], other_user.id
  	  assert_equal users.last['email'], other_user.email
  	  assert_equal users.last['name'], other_user.name
  	end

  	it "should respond with success" do
  	  expect(response).to be_success
  	end
  end

  describe "getting a single user with show action" do
  	let!(:micropost) { FactoryGirl.create(:micropost, user: user) }
  	before { get user_path(user.id), format: 'xml' }

  	it "should respond with the user's microposts" do
  	  user_response = Hash.from_xml(response.body)
  	  assert_equal user_response['microposts'].first['id'], micropost.id, "Micropost id was not correct"
  	  assert_equal user_response['microposts'].first['content'], micropost.content, "Micropost content was not correct"
  	end

  	it "should have the correct associated user" do
  	  user_response = Hash.from_xml(response.body)
  	  assert_equal user_response['microposts'].first['user_id'], user.id, "User was not correct"
  	end

  	it "should respond with success" do
  	  expect(response).to be_success
  	end
  end
	
end