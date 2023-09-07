import ballerina/io;

public function main() returns error? {
    // Creates a gRPC client to interact with the remote server.
    ChatClient ep = check new ("http://localhost:9090");

    // Executes the RPC call and receives the customized streaming client.
    ChatStreamingClient streamingClient = check ep->chat();
    // Reads the server responses in another strand.
    future<error?> f1 = start readResponse(streamingClient);
    // Sends multiple messages to the server.
    ChatMessage[] messages = [
        
        {title :"MATHEMATICS", author_1 :"Dan Kibwika ", optional_author_2 :"Roxxxy", location_of_the_book_in_library :  "NFQ54", ISBN : "9780134763416", status :  "Available"},
        {title :"Programming Edition 10 ", author_1 :"Mathiew Andree ", optional_author_2 :"None", location_of_the_book_in_library :  "NFQ54", ISBN : "9780134763416", status :  "Not available"},
        {title :"Life is Beautiful ", author_1 :"Serge Kayembe", optional_author_2 :"Karen Senga", location_of_the_book_in_library :  "H001", ISBN : "3780134763413", status :  "Available"},
        {title :"Eat that Frog", author_1 :"Brian Tracy ", optional_author_2 :"None", location_of_the_book_in_library :  "NFQ24", ISBN : "1780134763410", status :  "Not available"}

    ];
    foreach ChatMessage msg in messages {
        check streamingClient->sendChatMessage(msg);
    }
    // Once all the messages are sent, the client sends the message to notify the
    // server about the completion.
    check streamingClient->complete();
    // Waits until all server messages are received.
    check wait f1;
}

function readResponse(ChatStreamingClient streamingClient) returns error? {
    // Receives the server stream response iteratively.
    string? result = check streamingClient->receiveString();
    while !(result is ()) {
        io:println(result);
        result = check streamingClient->receiveString();
    }
}
