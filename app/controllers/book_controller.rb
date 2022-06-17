class BookController < ApplicationController
  def index
    #fetch all books from db 
    @books = Book.all
  end
end
