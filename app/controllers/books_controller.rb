# BOOKS = [
#   { id: 1, title: "Hidden Figures", author: "Margot Lee Shetterly", description: "Inspiring"},
#   { id: 2, title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz", description: "Best Ruby book"},
#   { id: 47, title: "Kindred", author: "Octavia E. Butler", description: "Scary"}
# ]

class BooksController < ApplicationController
  def index
    @books = Book.all.order(:title)
  end

  def show
    id = params[:id].to_i
    @book = Book.find_by(id: id)


    if @book.nil?
     render :notfound, status: :not_found
    end
  end

  def create
    @book = Book.new(author: params[:book][:author], title: params[:book][:title]) #instantiate a new book
    if @book.save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id].to_i)
  end

  def update
  end

  def destroy
  end







end
