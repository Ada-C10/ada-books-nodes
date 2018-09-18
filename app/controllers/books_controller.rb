BOOKS = [
  { id: 1, title: "Hidden Figures", author: "Margot Lee Shetterly", description: "Inspiring"},
  { id: 2, title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz", description: "Best Ruby book"},
  { id: 47, title: "Kindred", author: "Octavia E. Butler", description: "Scary"}
]

class BooksController < ApplicationController
  def index
    @books = BOOKS
  end

  def show
    id = params[:id]
    @book = BOOKS.find do |book|
      book[:id] == id.to_i
    end

    if @book.nil?
     render :notfound, status: :not_found
    end
  end







end
