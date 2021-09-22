require 'rails_helper'


RSpec.describe UserController, type: :controller do

    subject(:user) {User.create(
        username: 'jon',
        password: 'starwars'
    )}

    describe "post #create" do 
        it "validates username and passowrd" do 
            post :create, params { user: {username: 'jon', passowrd: 'starwars'}} 
            expect(response).to render_template("new")
        end
    end


end