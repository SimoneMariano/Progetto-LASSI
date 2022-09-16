require 'rails_helper'

describe AuthorsController, type: :controller do
    

    describe ".create" do
        before(:each) do
            @admin = create(:user, email: "admin@gmail.com", roles_mask: 2)
            sign_in @admin
        end
        context "logged admin create new author" do
            it "return new author" do
                author = Author.create(name: "Daniele Sette")
                expect(author).to be_valid
            end
 
        end
    end
    

end