require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) { User.create!( first_name: "Jeff",
    last_name: "Keslin",
    email: "jkeslin@gmail.com",
    password: "1234",
    password_confirmation: "1234" ) }

  it 'should have an index with a response of 200, OK' do
    get :index
    expect(response.status).to eq 200
  end

  describe "#new" do
    it "assigns the user to User.new" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    it "creates a new user if params are valid" do
      expect {
        post :create, user: {
          first_name: "Jeff",
          last_name: "Keslin",
          email: "jkeslin@gmail.com",
          password: "1234",
          password_confirmation: "1234"
        }
        }.to change {User.count}.by(1)
    end
  end

  describe "#show" do
    it 'shows the user' do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end