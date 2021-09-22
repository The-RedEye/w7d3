require 'rails_helper'


RSpec.describe UsersController, type: :controller do

    # subject(:user) {User.create(
    #     username: 'jon',
    #     password: 'starwars'
    # )}

    describe "get #new" do
        it "renders the form to create a user" do 
            get :new
            expect(response).to render_template("new")
        end
    end

    describe "POST #create" do 
        context "with valid parameters" do
            it "creates the user" do 
                post :create, params: { user: {username: 'jon', password: 'starwars'}} 
                expect(response).to render_template("index")
            end
        end

        context "with invalid parameters" do
            it "should not create the user" do 
                post :create, params: { user: {username: 'jon', password: "hi" }} 
                expect(response).to render_template("new")
            end
        end

        
    end

    describe "get #index" do
        it "renders the index page" do 
            get :index
            expect(response).to render_template("index")
        end
    end




end