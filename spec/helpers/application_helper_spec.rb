require 'spec_helper'
	
describe ApplicationHelper do
		
	describe "full_title" do
		it "should include the page title" do	
			expect(full_title("foo")).to match(/foo/) 
		end

		it "should include the base title" do
			expect(full_title("foo")).to match(/Ruby on Rails Tutorial Sample App/) 
		end

		it "should not include a bar for the home page" do
			expect(full_title("")).not_to match(/\|/)
		end
	end

	describe "user_name_reply" do
		let(:user) { User.new(name:"Michael Hartl",email:"123@123.com",password:"123456") }

		it "should include the @ sign" do
			expect(user_name_reply(user)).to match(/@/) 
		end

		it "should have the user id after the @ sign" do
			expect(user_name_reply(user)).to match(/#{user.id}/) 
		end

		it "should have the user name separated by - after the id" do
			expect(user_name_reply(user)).to match(/-michael-hartl/)
		end
	end
end