import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.wrappers;

public const string GRPC_BIDIRECTIONAL_STREAMING_DESC = "0A22677270635F6269646972656374696F6E616C5F73747265616D696E672E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22DB010A0B436861744D65737361676512140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F7231122A0A116F7074696F6E616C5F617574686F725F32180320012809520F6F7074696F6E616C417574686F723212430A1F6C6F636174696F6E5F6F665F7468655F626F6F6B5F696E5F6C696272617279180420012809521A6C6F636174696F6E4F66546865426F6F6B496E4C69627261727912120A044953424E18052001280952044953424E12160A067374617475731806200128095206737461747573323E0A044368617412360A0463686174120C2E436861744D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33";

public isolated client class ChatClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, GRPC_BIDIRECTIONAL_STREAMING_DESC);
    }

    isolated remote function chat() returns ChatStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("Chat/chat");
        return new ChatStreamingClient(sClient);
    }
}

public client class ChatStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendChatMessage(ChatMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextChatMessage(ContextChatMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class ChatStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextChatMessageStream record {|
    stream<ChatMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextChatMessage record {|
    ChatMessage content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: GRPC_BIDIRECTIONAL_STREAMING_DESC}
public type ChatMessage record {|
    string title = "";
    string author_1 = "";
    string optional_author_2 = "";
    string location_of_the_book_in_library = "";
    string ISBN = "";
    string status = "";
|};

