# BOOKS = [
#   { id: 1, title: "Hidden Figures", author: "Margot Lee Shetterly", description: "Inspiring"},
#   { id: 2, title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz", description: "Best Ruby book"},
#   { id: 47, title: "Kindred", author: "Octavia E. Butler", description: "Scary"}
# ]

class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]


  def index
    if params[:author_id]
      author_id = params[:author_id]
      @books = Author.find_by(id: author_id).books.order(:title)
    else
      @books = Book.all.order(:title)
    end
  end

  def show;  end


  def new
    @book = Book.new
    if params[:author_id]
      @author_id = params[:author_id].to_i
      author = Author.find_by(id: @author_id)
      if author.nil?
        flash.now[:warning] = "That author doesn't exit"
      end
      @book.author_id = @author_id

    end
  end

  def edit; end



  def destroy
    unless @book.nil?
      @book.destroy
      flash[:success] = "#{@book.title} deleted"
      redirect_to root_path
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save # save returns true if the database insert succeeds
      flash[:success] = 'Book Created!'

      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      flash.now[:danger] = 'Book not created!'

      render :new, status: :bad_request # show the new book form view again
    end
  end

  def update
    if @book && @book.update(book_params)
      redirect_to book_path(@book.id)
    elsif @book
      render :edit, status: :bad_request
    end
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id].to_i)

    if @book.nil?
      flash.now[:danger] = "Cannot find the book #{params[:id]}"
      render :notfound, status: :not_found
    end
  end

  def book_params
    return params.require(:book).permit(:title, :author_id, :description)
  end







end
