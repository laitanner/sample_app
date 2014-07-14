require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      it "should show the total feeds" do
        expect(page).to have_content("micropost".pluralize(user.feed.count))
      end

      it "should paginate the user's feed" do
        user.feed.paginate(page: 1).each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "replies" do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:third_user ) { FactoryGirl.create(:user) }
        let(:post1) { FactoryGirl.create(:micropost, user: other_user, content: "#{user_name_reply(user)}") }
        
        before { third_user.follow!(user) }
        
        it "should show the reply post on the replied to user's page" do
          expect(page).to have_content(post1.content)
        end

        it "should show the reply post on the replier's page" do
          click_link "Sign out"
          visit signin_path
          fill_in "Email",    with: other_user.email
          fill_in "Password", with: other_user.password
          click_button "Sign in"
          expect(page).to have_content(post1.content)
        end

        it "should not show the reply post on any other pages" do
          click_link "Sign out"
          visit signin_path
          fill_in "Email",    with: third_user.email
          fill_in "Password", with: third_user.password
          click_button "Sign in"
          expect(page).not_to have_content(post1.content)
        end
      end 

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading)    { 'About' }
    let(:page_title) { 'About Us' }
    
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }
    
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
  end
end