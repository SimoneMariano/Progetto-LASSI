require 'rails_helper'

describe AuthorsController do

    describe ".create" do
        context "logged admin create new author" do
            it "return new author" do
                author = Author.create(name: "Daniele Sette")
                expect(author).to be_valid
            end
 
        end
    end
    

end