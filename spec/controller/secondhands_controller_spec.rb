require 'rails_helper'


describe SecondhandsController, type: :controller do
#User can't add secondhand for the same book several times at the same time
    describe ".create" do

        before(:each) do
            @user = create(:user, email: "user@gmail.com")
            sign_in @user

            create(:book, id: 1)
        end

        context "user logged in and existing book with isbn 9788808420206" do
            it "successfully add secondhand" do 
                book = Book.find_by(ISBN: 9788808420206)
                secondhand = Secondhand.create(id: 1, description: "Some description")
                secondhand.user = @user
                secondhand.book = book
                secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")
                expect(secondhand).to be_valid  
                 
            end
        end

        context "user logged in and existing secondhand on the book with isbn 9788808420206 from the same user" do
            before(:each) do
                secondhand = Secondhand.create(id: 1, description: "Some description")
                secondhand.user = @user
                secondhand.book = Book.find_by(ISBN: 9788808420206)
                secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

                secondhand.save
            end

            it "not add secondhand" do
                secondhand = Secondhand.create(id: 1, description: "Some description")
                secondhand.user = @user
                secondhand.book = Book.find_by(ISBN: 9788808420206)
                secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

                expect(secondhand.save).to eq(false)
                
            end
        end
    end

    
    describe ".approve" do

        before(:each) do
            @admin = create(:user, id: 2, email: "admin@gmail.com", roles_mask: 2)
            sign_in @admin

            create(:book, id: 1)
            initialize_secondhand
        end

        context "admin logged in and want to approve secondhand on the book with isbn 9788808420206 from user with id 1" do
            it "was successfully approved" do
                book = Book.find_by(ISBN: 9788808420206)
                secondhand = Secondhand.find_by(book_id: book.id, user_id: 1)
                get :approve, params: { id: secondhand.id }

                secondhand.reload
                expect(secondhand.approved).to eq(true)
                expect(flash[:notice]).to eq("Secondhand was successfully approved.")

            end

        end
    end

    private def initialize_secondhand

        user = create(:user, id: 1, email: "user@gmail.com")

        secondhand = Secondhand.create(id: 1, description: "Some description")
        secondhand.user = user
        secondhand.book = Book.find_by(ISBN: 9788808420206)
        secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

        secondhand.save
    end

    

end