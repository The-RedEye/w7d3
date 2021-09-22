require 'rails_helper.rb'

RSpec.describe User, type: :model do
   

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    # it { should validate_presence_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}
    
    describe "uniqueness" do
        before :each do
            create(:user)
        end
        it { should validate_uniqueness_of(:username) }
    end

    describe "is_password?" do
        let!(:user) {create(:user)}
        context "with a valid password" do
            it "should return true" do
                expect(user.is_password?('password')).to be true
            end
        end

        context "with an invalid password" do
            it "should return false" do
                expect(user.is_password?('starwars')).to be false
            end
        end
    end

    describe "password encryption" do
        it "does not save passwords to the database" do
            FactoryBot.create(:user, username: "stan")
            user=User.find_by(username: "stan")
            expect(user.password).not_to eq("password")
        end

        it "does encrypt passowrd using BCrypt" do
            expect(BCrypt::Password).to receive(:create).with("whatever")
            FactoryBot.build(:user, password:"whatever")
        end
    end


end