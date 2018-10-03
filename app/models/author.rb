class Author < ApplicationRecord
  has_many :books

  def self.author_list
    return Author.all.map do |author|
      [author.name , author.id]
    end
  end

  def first_published
    books_with_year = self.books.where.not(date_published: nil)
    first_book = books_with_year.order(date_published: :asc).first
    if first_book != nil
      return first_book.date_published
    else
      return nil
    end
  end

  def most_recent_book
    books_with_year = self.books.where.not(date_published: nil)
    latest_book = books_with_year.order(date_published: :asc).last
    if latest_book != nil
      return latest_book.title
    else
      return nil
    end
  end
end
