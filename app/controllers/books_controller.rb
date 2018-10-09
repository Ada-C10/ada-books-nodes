# BOOKS = [
#   { id: 1, title: "Hidden Figures", author: "Margot Lee Shetterly", description: "Inspiring"},
#   { id: 2, title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz", description: "Best Ruby book"},
#   { id: 47, title: "Kindred", author: "Octavia E. Butler", description: "Scary"}
# ]

class BooksController < ApplicationController
  def index
    if params[:author_id]
      author_id = params[:author_id]
      @books = Author.find_by(id: author_id).books.order(:title)
    else
      @books = Book.all.order(:title)
    end
  end

  def show
    id = params[:id].to_i
    @book = Book.find_by(id: id)


    if @book.nil?
      render :notfound, status: :not_found
    end
  end


  def new
    @book = Book.new
    if params[:author_id]
      @author_id = params[:author_id].to_i
      @book.author_id = @author_id
    end
  end

  def edit
    @book = Book.find(params[:id].to_i)
  end



  def destroy
    book = Book.find_by(id: params[:id].to_i)
    if book.nil?
      flash[:error] = "Book #{params[:id]} not found"
    else
      @deleted_book = book.destroy
      flash[:success] = "#{book.title} deleted"
    end

    redirect_to root_path
  end

  def create
    @book = Book.new(book_params)
    if @book.save # save returns true if the database insert succeeds
      flash[:success] = 'Book Created!'

      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      flash.now[:error] = 'Book not created!'
      @book.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new # show the new book form view again
    end
  end

  def update
    @book = Book.find_by(id: params[:id].to_i)
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    return params.require(:book).permit(:title, :author_id, :description)
  end







end
