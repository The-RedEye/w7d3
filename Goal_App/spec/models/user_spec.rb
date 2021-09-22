require 'rails_helper.rb'

RSpec.describe User, type: :model do
   
    subject(:user1) {User.create(
        username: 'jon',
        password: 'starwars'
    )}

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_length_of(:password).is_at_least(6)}
    
    it { should validate_uniqueness_of(:username) }

    # describe "uniqueness" do
    #     before :each do
    #         create(:user)
    #     end
    #     it { should validate_uniqueness_of(:username) }
    # end

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
            FactoryBot.create(:user, username: "emily")
            user=User.find_by(username: "emily")
            expect(user.password).not_to eq("password")
        end

        it "does encrypt passowrd using BCrypt" do
            expect(BCrypt::Password).to receive(:create).with("whatever")
            FactoryBot.build(:user, password:"whatever")
        end
    end

    describe "find_by_credentials" do 
        FactoryBot.create(:user, username: "laura")
        it "finds a used by credentials" do
            expect(User.find_by_credentials("laura", "password")).to_not be nil
        end
        it "returns nil if not found" do 
            expect(User.find_by_credentials("laura", "what")).to be nil
        end
    end


end