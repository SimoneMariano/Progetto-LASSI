require 'rails_helper'


describe BooksController, type: :controller do

    before(:each) do
        @user = create(:user)
        sign_in @user
    end


    describe ".create" do
        
        before(:each) do
            sign_out @user
            @admin = create(:user, email: "admin@gmail.com", roles_mask: 2)
            sign_in @admin
        end

        context "admin logged in" do
            it "returns create successfully" do
                book = Book.create(
                    id: 1,
                    ISBN: 9788808420206,
                    title: "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.",
                    stock: 3,
                    description: "Libro di Fisica 1"
                )

                book.author << create(:author, name: "Daniele Sette")
                book.author << create(:author, name: "Mario Bertolotti")
                book.author << create(:author, name: "Adriano Alippi")
                book.course << create(:course, name: "Ingegneria Informatica e Automatica")
                book.course << create(:course, name: "Fisica")
                book.category << create(:category, name: "Fisica")

                book.placeholder.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")


                  
                expect(book).to be_valid   
            end
        end
        
    end

    describe ".addToFavorites" do

        before(:each) do

            initialize_book
        end

        context "given a book with id 1 and logged in user" do
            it "add successfully to favorites list" do
                book = Book.find(1)
                get :addToFavorites, params: { id: book.id}

                expect { get :show, :id => book.id }
                expect(flash[:notice]).to eq("Book was successfully added to favourites.")
            end

        end

        context "given a book with id 1 and logged in user already in favorites list" do

            before(:each) do
                @user.book << Book.find(1)
            end

            it "remove successfully from favorites list" do
                book = Book.find(1)
                get :addToFavorites, params: { id: book.id}

                expect { get :show, :id => book.id }
                expect(flash[:notice]).to eq("Book was successfully removed from favourites.")
            end

        end

    end

    describe ".update" do 
        before(:each) do

            initialize_book
        end

        context "given a book with id 1 and logged as administrator" do
            before(:each) do
                sign_out @user
                @admin = create(:user, email: "admin@gmail.com", roles_mask: 2)
                sign_in @admin
            end

            it "update successfully book" do
                book = Book.find(1)
                attr = {
                        description: 'Edited description',
                       }
                put :update, params: { 
                                        id: book.id, 
                                        book: attr, 
                                        authors: book.author.ids,
                                        categories: book.category.ids,
                                        courses: book.course.ids
                                    }
                book.reload
                expect(book.description).to eq("Edited description")
                expect(flash[:notice]).to eq("Book was successfully updated.")
            end
        end

        context "given a book with id 1 and logged as student" do
            it "update successfully book" do
                book = Book.find(1)
                attr = {
                        description: 'Edited description',
                       }
                put :update, params: { 
                                        id: book.id, 
                                        book: attr, 
                                        authors: book.author.ids,
                                        categories: book.category.ids,
                                        courses: book.course.ids
                                    }
                book.reload
                expect(book.description).to eq("Libro di Fisica 1")
                expect(flash[:alert]).to eq("BEWARE: you are not authorized to edit books.")
                
            end
        end
    end

    describe ".destroy" do
        context "given a book with id 1 and logged as administrator" do
            before(:each) do
                sign_out @user
                @admin = create(:user, email: "admin@gmail.com", roles_mask: 2)
                sign_in @admin

                initialize_book
            end

            it "deleted book from catalog" do
                book = Book.find(1)

                post :destroy, params: {id: book.id}
                
                expect { book.reload }.to raise_error
                expect(flash[:notice]).to eq("Book was successfully destroyed.")
                

            end
        end
    end


    private def initialize_book
        book = Book.create(
            id: 1,
            ISBN: 9788808420206,
            title: "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.",
            stock: 3,
            description: "Libro di Fisica 1"
        )
        book.author << create(:author, name: "Daniele Sette")
        book.author << create(:author, name: "Mario Bertolotti")
        book.author << create(:author, name: "Adriano Alippi")
        book.course << create(:course, name: "Ingegneria Informatica e Automatica")
        book.course << create(:course, name: "Fisica")
        book.category << create(:category, name: "Fisica")

        book.placeholder.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")
        book.save
    end

    

end
