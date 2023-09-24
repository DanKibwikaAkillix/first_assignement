import ballerina/grpc;
import ballerina/protobuf;

public const string INTERFACE_DESC = "0A0F696E746572666163652E70726F746F22070A05456D707479221A0A044953424E12120A046973626E18012001280952046973626E22EB010A04426F6F6B12120A046973626E18012001280952046973626E12140A057469746C6518022001280952057469746C6512180A07617574686F72311803200128095207617574686F723112180A07617574686F72321804200128095207617574686F7232122A0A086C6F636174696F6E18052001280E320E2E426F6F6B2E4C6F636174696F6E52086C6F636174696F6E121F0A0B626F72726F7765645F6279180620012809520A626F72726F7765644279121C0A09617661696C61626C651807200128085209617661696C61626C65221A0A084C6F636174696F6E12060A024131100012060A02413210012280010A045573657212170A07757365725F69641801200128095206757365724964121B0A0966756C6C5F6E616D65180220012809520866756C6C4E616D65121E0A04726F6C6518032001280E320A2E557365722E526F6C655204726F6C6522220A04526F6C65120B0A0753545544454E541000120D0A094C494252415249414E100122230A074D65737361676512180A076D65737361676518012001280952076D657373616765222A0A0B4C6973744F66426F6F6B73121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322450A13426F6F6B456E7175697279526573706F6E736512140A05666F756E641801200128085205666F756E6412180A076D65737361676518022001280952076D65737361676522430A14426F72726F77696E67496E666F726D6174696F6E12170A07757365725F6964180120012809520675736572496412120A046973626E18022001280952046973626E32ED030A074C69627261727912170A07616464426F6F6B12052E426F6F6B1A052E4953424E12200A0B637265617465557365727312052E557365721A082E4D6573736167652801121D0A0A757064617465426F6F6B12052E426F6F6B1A082E4D65737361676512210A0A72656D6F7665426F6F6B12052E4953424E1A0C2E4C6973744F66426F6F6B73122A0A126C697374417661696C61626C65426F6F6B7312062E456D7074791A0C2E4C6973744F66426F6F6B7312290A0A6C6F63617465426F6F6B12052E4953424E1A142E426F6F6B456E7175697279526573706F6E7365122D0A0A626F72726F77426F6F6B12152E426F72726F77696E67496E666F726D6174696F6E1A082E4D65737361676512290A116C697374426F72726F776564426F6F6B7312062E456D7074791A0C2E4C6973744F66426F6F6B73122D0A0A72657475726E426F6F6B12152E426F72726F77696E67496E666F726D6174696F6E1A082E4D657373616765122B0A11736561726368426F6F6B42795469746C6512082E4D6573736167651A0C2E4C6973744F66426F6F6B73122C0A12736561726368426F6F6B4279417574686F7212082E4D6573736167651A0C2E4C6973744F66426F6F6B73122A0A10736561726368426F6F6B42794953424E12082E4D6573736167651A0C2E4C6973744F66426F6F6B73620670726F746F33";

public isolated client class LibraryClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, INTERFACE_DESC);
    }

    isolated remote function addBook(Book|ContextBook req) returns ISBN|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ISBN>result;
    }

    isolated remote function addBookContext(Book|ContextBook req) returns ContextISBN|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ISBN>result, headers: respHeaders};
    }

    isolated remote function updateBook(Book|ContextBook req) returns Message|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Message>result;
    }

    isolated remote function updateBookContext(Book|ContextBook req) returns ContextMessage|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Message>result, headers: respHeaders};
    }

    isolated remote function removeBook(ISBN|ContextISBN req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        ISBN message;
        if req is ContextISBN {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function removeBookContext(ISBN|ContextISBN req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        ISBN message;
        if req is ContextISBN {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function listAvailableBooks(Empty|ContextEmpty req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function listAvailableBooksContext(Empty|ContextEmpty req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function locateBook(ISBN|ContextISBN req) returns BookEnquiryResponse|grpc:Error {
        map<string|string[]> headers = {};
        ISBN message;
        if req is ContextISBN {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BookEnquiryResponse>result;
    }

    isolated remote function locateBookContext(ISBN|ContextISBN req) returns ContextBookEnquiryResponse|grpc:Error {
        map<string|string[]> headers = {};
        ISBN message;
        if req is ContextISBN {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BookEnquiryResponse>result, headers: respHeaders};
    }

    isolated remote function borrowBook(BorrowingInformation|ContextBorrowingInformation req) returns Message|grpc:Error {
        map<string|string[]> headers = {};
        BorrowingInformation message;
        if req is ContextBorrowingInformation {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Message>result;
    }

    isolated remote function borrowBookContext(BorrowingInformation|ContextBorrowingInformation req) returns ContextMessage|grpc:Error {
        map<string|string[]> headers = {};
        BorrowingInformation message;
        if req is ContextBorrowingInformation {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Message>result, headers: respHeaders};
    }

    isolated remote function listBorrowedBooks(Empty|ContextEmpty req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/listBorrowedBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function listBorrowedBooksContext(Empty|ContextEmpty req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/listBorrowedBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function returnBook(BorrowingInformation|ContextBorrowingInformation req) returns Message|grpc:Error {
        map<string|string[]> headers = {};
        BorrowingInformation message;
        if req is ContextBorrowingInformation {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/returnBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Message>result;
    }

    isolated remote function returnBookContext(BorrowingInformation|ContextBorrowingInformation req) returns ContextMessage|grpc:Error {
        map<string|string[]> headers = {};
        BorrowingInformation message;
        if req is ContextBorrowingInformation {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/returnBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Message>result, headers: respHeaders};
    }

    isolated remote function searchBookByTitle(Message|ContextMessage req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByTitle", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function searchBookByTitleContext(Message|ContextMessage req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByTitle", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function searchBookByAuthor(Message|ContextMessage req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByAuthor", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function searchBookByAuthorContext(Message|ContextMessage req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByAuthor", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function searchBookByISBN(Message|ContextMessage req) returns ListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByISBN", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListOfBooks>result;
    }

    isolated remote function searchBookByISBNContext(Message|ContextMessage req) returns ContextListOfBooks|grpc:Error {
        map<string|string[]> headers = {};
        Message message;
        if req is ContextMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/searchBookByISBN", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListOfBooks>result, headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Library/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveMessage() returns Message|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <Message>payload;
        }
    }

    isolated remote function receiveContextMessage() returns ContextMessage|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <Message>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextISBN record {|
    ISBN content;
    map<string|string[]> headers;
|};

public type ContextMessage record {|
    Message content;
    map<string|string[]> headers;
|};

public type ContextBookEnquiryResponse record {|
    BookEnquiryResponse content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextListOfBooks record {|
    ListOfBooks content;
    map<string|string[]> headers;
|};

public type ContextBorrowingInformation record {|
    BorrowingInformation content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type User record {|
    string user_id = "";
    string full_name = "";
    User_Role role = STUDENT;
|};

public enum User_Role {
    STUDENT, LIBRARIAN
}

@protobuf:Descriptor {value: INTERFACE_DESC}
public type ISBN record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type Message record {|
    string message = "";
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type BookEnquiryResponse record {|
    boolean found = false;
    string message = "";
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type Book record {|
    string isbn = "";
    string title = "";
    string author1 = "";
    string author2 = "";
    Book_Location location = A1;
    string borrowed_by = "";
    boolean available = false;
|};

public enum Book_Location {
    A1, A2
}

@protobuf:Descriptor {value: INTERFACE_DESC}
public type ListOfBooks record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: INTERFACE_DESC}
public type BorrowingInformation record {|
    string user_id = "";
    string isbn = "";
|};

