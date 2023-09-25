

isolated class Database{
    private table<Book> key(isbn) books = table[];
    private table<User> key(user_id) users = table[];

    isolated function addBook(Book book) returns ISBN|error{
        lock{
            error? result = self.books.add(book.clone());
            if(result is error){
                return error("BadRequest");
            }
            return {isbn: book.isbn};
        }
    }

    isolated function createUser(User user) returns string{
        lock{
            error? result = self.users.add(user.clone());
            if(result is error){
                return user.full_name + " of ID:" + user.user_id + " could not be added";
            }
            return user.full_name + " added successfully.";
        }
    }

    isolated function updateBook(Book book) returns Message|error{
        lock{
            error? result = self.books.put(book.clone());
            if(result is error){
                return error("Bad Request");
            }
            return {message: "Book Updated"};
        }
    }

    isolated function removeBook(ISBN isbn) returns ListOfBooks|error {
        lock{
            Book? book = self.books.get(isbn.isbn);
            if book is (){
                return error("badrequest");
            }
            _ = self.books.remove(isbn.isbn);
            ListOfBooks list = {
                books: from var x in self.books where x.available == true select x
            };
            return list.clone();
        }
    }

    isolated function listAvailableBooks() returns ListOfBooks|error{
        lock{
            return {
                books: (from var book in self.books where book.available == true select book).toArray()
            }.clone();
        }
    }

    isolated function locateBook(ISBN isbn) returns BookEnquiryResponse|error{
        lock{
            Book? book = self.books.get(isbn.isbn);
            if !(book is ()){
                return {
                    found: true, message: book.location
                };
            }
            return {
                found: false, message: "Not Found"
            };
        }
    }

    isolated function borrowBook(BorrowingInformation info) returns Message|error{
        lock{
            Book? book = self.books.get(info.isbn);
            User? user = self.users.get(info.user_id);
            if book is (){
                return {message: "book not found"};
            }
            if user is (){
                return {message: "user not found"};
            }
            if book.available is false{
                return {message: "book not available"};
            }
            book.available = false;
            book.borrowed_by = user.user_id;
            return {message: "success"};
        }
    }

    isolated function listBorrowedBooks() returns ListOfBooks|error{
        lock{
            Book[] books = from var book in self.books
                                    where book.available is false
                                    select book;
            return {books: books.clone()};
        }
    }

    isolated function returnBook(BorrowingInformation info) returns Message|error{
        lock{
            Book? book = self.books.get(info.isbn);
            User? user = self.users.get(info.user_id);
            if book is (){
                return {message: "book not found"};
            }
            if user is (){
                return {message: "user not found"};
            }
            if book.available == true{
                return {message: "not borrowed"};
            }
            if user.user_id != book.borrowed_by{
                return {message: "not yours"};
            }
            book.available = true;
            book.borrowed_by = "";
            return {message: "success"};
        }
    }

    isolated function searchBookByAuthor(string keyword) returns ListOfBooks|error{
        lock{
            return {
                books: (from var book in self.books
                                where book.author1.includes(keyword) || book.author2.includes(keyword)
                                select book).clone().toArray()
            };
        }
    }

    isolated function searchBookByTitle(string keyword) returns ListOfBooks|error{
        lock{
            return {
                books: (from var book in self.books
                                where book.title.includes(keyword)
                                select book).clone().toArray()
            };
        }
    }

    isolated function searchBookByISBN(string keyword) returns ListOfBooks|error{
        lock{
            return {
                books: (from var book in self.books
                                where book.isbn.equalsIgnoreCaseAscii(keyword)
                                select book).clone().toArray()
            };
        }
    }
}