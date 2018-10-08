authors = [
  {
    name: "Sandi Metz",
    publisher: "Wesley",
    nationality: 34
  },
  {
    name: "N K Jemisin",
    publisher: "Tor",
    nationality: 1
  },
  {
    name: "Nnedi Okorafor",
    publisher: "Tor",
    nationality: 234
  },
  {
    name: "Roxane Gay",
    publisher: "Scholastic",
    nationality: 1
  },
  {
    name: "JK Rowling",
    publisher: "Scholastic",
    nationality: 43
  },
  {
    name: "Margot Lee Shetterly",
    publisher: "Scholastic",
    nationality: 1
  }
]

books = [
  {
    title: "99 bottles of Oop",
    description: "A great oop book",
    date_published: DateTime.new(2013, 1, 1),
    author_name: "Sandi Metz",
    author_id: 0
  },
  {
    title: "POODR",
    description: "A great rails book",
    date_published: DateTime.new(2011, 1, 1),
    author_name: "Sandi Metz",
    author_id: 0
  },
  {
    title: "The Hundred Thousand Kingdoms",
    description: "Her first book",
    date_published: DateTime.new(2010, 1, 1),
    author_name: "N K Jemisin",
    author_id: 0
  },
  {
    title: "The Stone Sky",
    description: "The third Hugo winning book in the Broken Earth Trilogy",
    date_published: DateTime.new(2017, 1, 1),
    author_name: "N K Jemisin",
    author_id: 0
  },
  {
    title: "Binti",
    description: "A nebula winning novella",
    date_published: DateTime.new(2015, 1, 1),
    author_name: "Nnedi Okorafor",
    author_id: 0
  },
  {
    title: "Who Fears Death",
    description: "A brilliant and sad book",
    date_published: DateTime.new(2010, 1, 1),
    author_name: "Nnedi Okorafor",
    author_id: 0
  },
  {
    title: "Hunger",
    description: "A biography",
    date_published: DateTime.new(2017, 1, 1),
    author_name: "Roxane Gay",
    author_id: 0
  },
  {
    title: "Bad Feminist",
    description: "A great collection of essays",
    date_published: DateTime.new(2014, 1, 1),
    author_name: "Roxane Gay",
    author_id: 0
  },
  {
    title: "The Deathly Hallows",
    description: "The tale of sad wizards",
    date_published: DateTime.new(2007, 1, 1),
    author_name: "JK Rowling",
    author_id: 0
  },
  {
    title: "Hidden Figures",
    description: "A good book that existed before the movie",
    date_published: DateTime.new(2008, 1, 1),
    author_name: "Margot Lee Shetterly",
    author_id: 0
  }
]

genres = [
  {
    name: 'mystery'
  },
  {
    name: 'Sci Fi'
  },
  {
    name: 'Horror'
  }
]

genres.each do |genre|
  Genre.create(genre)
end


failedAuthors = []
failedBooks = []
authors.each do |author|
  if Author.create(author)
    puts "Added #{author[:name]} to database"
  else
    failedAuthors << author
  end
end
if failedAuthors.length > 0
  puts "#{failedAuthors.length} authors failed out of #{authors.length} total authors"
end

books.each do |book|
  book[:author_id] = Author.find_by(name: book[:author_name]).id
  book.delete(:author_name)
  if Book.create(book)
    puts "Added #{book[:title]} to database"
  else
    failedBooks << book
  end
end

if failedBooks.length > 0
  puts "#{failedBooks.length} books failed to load out of #{books.length} total books"
end

Book.first.genres << Genre.first
Book.last.genres << Genre.first
Book.all[2].genres << Genre.all.sample
