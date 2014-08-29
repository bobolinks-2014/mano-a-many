require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe SessionsController, :type => :controller do

  before do
    @user = User.create(first_name: "Jeff", last_name: "Keslin", email: "jkeslin@gmail.com", password: "1234", password_confirmation: "1234")
  end

  describe "#create" do
    it "should successfully create a session and redirect to index" do
      expect(session[:user_id]).to be_nil
      post :create, user: {:email => "jkeslin@gmail.com", :password => "1234"}
      expect(session[:user_id]).to eq(@user.id)
      expect(response).to redirect_to(user_url(@user))
    end

    it "should redirect the user to the root url if login is unsuccessful" do
      post :create, user: {:email => "bob@steve.com", :password => "4321"}
      expect(response).to redirect_to(root_url)
    end
  end

  describe "#destroy" do
    it "should successfully clear a session and redirect to index" do
      post :create, user: {:email => "jkeslin@gmail.com", :password => "1234"}
      expect(session[:user_id]).to eq(@user.id)
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end