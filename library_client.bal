import ballerina/io;

LibraryClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    io:println("\nDemonstrating Add-Book Function----------");
    Book addBookRequest = {isbn: "book1", title: "maths", author1: "author1", author2: "author2", location: "A1", borrowed_by: "", available: true};
    Book addBookRequest2 = {isbn: "book2", title: "physics", author1: "author1", author2: "author2", location: "A1", borrowed_by: "", available: true};
    Book addBookRequest3 = {isbn: "book3", title: "bio", author1: "author1", author2: "author2", location: "A2", borrowed_by: "", available: true};
    Book addBookRequest4 = {isbn: "book4", title: "history", author1: "author1", author2: "author2", location: "A2", borrowed_by: "", available: true};
    ISBN addBookResponse = check ep->addBook(addBookRequest);
    ISBN addBookResponse2 = check ep->addBook(addBookRequest2);
    ISBN addBookResponse3 = check ep->addBook(addBookRequest3);
    ISBN addBookResponse4 = check ep->addBook(addBookRequest4);
    io:println(addBookResponse);
    io:println(addBookResponse2);
    io:println(addBookResponse3);
    io:println(addBookResponse4);




    io:println("\n\n\nDemonstrating List-Available-Books Function----------");
    Empty listAvailableBooksRequest00 = {};
    ListOfBooks listAvailableBooksResponse00 = check ep->listAvailableBooks(listAvailableBooksRequest00);
    io:println(listAvailableBooksResponse00);



    io:println("\n\n\nDemonstrating Remove-Book Function----------");
    ISBN removeBookRequest = {isbn: "book4"};
    ListOfBooks removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);




    io:println("\n\n\nDemonstrating Create-Users Function----------");
    User[] users = [
        {user_id: "1", full_name: "user1", role: "STUDENT"},
        {user_id: "2", full_name: "user2", role: "STUDENT"},
        {user_id: "3", full_name: "user3", role: "LIBRARIAN"}
        ];
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    foreach var user in users{
        check createUsersStreamingClient->sendUser(user);
    }
    check createUsersStreamingClient->complete();
    Message? createUsersResponse = check createUsersStreamingClient->receiveMessage();
    io:println(createUsersResponse);




    io:println("\n\n\nDemonstrating Update-Book Function----------");
    Book updateBookRequest = {isbn: "book1", title: "maths", author1: "N.Nashandi", author2: "I.Makosa", location: "A1", borrowed_by: "", available: true};
    Message updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);




    io:println("\n\n\nDemonstrating Locate-Book Function----------");
    ISBN locateBookRequest = {isbn: "book3"};
    BookEnquiryResponse locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);




    io:println("\n\n\nDemonstrating List-Available-Books Function----------");
    Empty listAvailableBooksRequest = {};
    ListOfBooks listAvailableBooksResponse = check ep->listAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);




    io:println("\n\n\nDemonstrating Borrow-Book Function----------");
    BorrowingInformation borrowBookRequest = {user_id: "1", isbn: "book1"};
    Message borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);




    io:println("\n\n\nDemonstrating List-Available-Books Function----------");
    Empty listAvailableBooksRequest2 = {};
    ListOfBooks listAvailableBooksResponse2 = check ep->listAvailableBooks(listAvailableBooksRequest2);
    io:println(listAvailableBooksResponse2);




    io:println("\n\n\nDemonstrating List-Borrowed-Books Function----------");
    Empty listBorrowedBooksRequest = {};
    ListOfBooks listBorrowedBooksResponse = check ep->listBorrowedBooks(listBorrowedBooksRequest);
    io:println(listBorrowedBooksResponse);




    io:println("\n\n\nDemonstrating Return-Book Function----------");
    BorrowingInformation returnBookRequest = {user_id: "1", isbn: "book1"};
    Message returnBookResponse = check ep->returnBook(returnBookRequest);
    io:println(returnBookResponse);




    io:println("\n\n\nDemonstrating List-Available-Books Function----------");
    Empty listAvailableBooksRequest3 = {};
    ListOfBooks listAvailableBooksResponse3 = check ep->listAvailableBooks(listAvailableBooksRequest3);
    io:println(listAvailableBooksResponse3);




    io:println("\n\n\nDemonstrating Search-Book Function----------");
    Message searchBookByTitleRequest = {message: "s"};
    ListOfBooks searchBookByTitleResponse = check ep->searchBookByTitle(searchBookByTitleRequest);
    io:println(searchBookByTitleResponse);
}

