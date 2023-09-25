import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: INTERFACE_DESC}
isolated service "Library" on ep {

    private Database db = new ();
    remote function addBook(Book value) returns ISBN|error {
        lock{
            return self.db.addBook(value.clone());
        }
    }
    remote function updateBook(Book value) returns Message|error {
        lock{
            return self.db.updateBook(value.clone());
        }
    }
    remote function removeBook(ISBN value) returns ListOfBooks|error {
        lock{
            return self.db.removeBook(value.clone());
        }
    }
    remote function listAvailableBooks(Empty value) returns ListOfBooks|error {
        lock{
            return self.db.listAvailableBooks();
        }
    }
    remote function locateBook(ISBN value) returns BookEnquiryResponse|error {
        lock{
            return self.db.locateBook(value.clone());
        }
    }
    remote function borrowBook(BorrowingInformation value) returns Message|error {
        lock{
            return self.db.borrowBook(value.clone());
        }
    }
    remote function listBorrowedBooks(Empty value) returns ListOfBooks|error {
        lock{
            return self.db.listBorrowedBooks();
        }
    }
    remote function returnBook(BorrowingInformation value) returns Message|error {
        lock{
            return self.db.returnBook(value.clone());
        }
    }
    remote function searchBookByTitle(Message value) returns ListOfBooks|error {
        lock{
            return self.db.searchBookByTitle(value.message.toString());
        }
    }
    remote function searchBookByAuthor(Message value) returns ListOfBooks|error {
        lock{
            return self.db.searchBookByAuthor(value.message.toString());
        }
    }
    remote function searchBookByISBN(Message value) returns ListOfBooks|error {
        lock{
            return self.db.searchBookByISBN(value.message.toString());
        }
    }
    remote function createUsers(stream<User, grpc:Error?> clientStream) returns Message|error {
        
        string response = "";

        grpc:Error? forEach = clientStream.forEach(function (User user){
            response += "\n" + (self.db.createUser(user));
        });
        if forEach is grpc:Error {
            return error("Internal Server Error");
        }
        return {message: response};

        
    }
}

