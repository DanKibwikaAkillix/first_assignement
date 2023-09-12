import ballerina/http;

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

service / on ep0 {
    resource function get lecturers() returns InlineResponse200[] {
    }
    resource function post lecturers(@http:Payload LecturersBody payload) returns http:Created|http:BadRequest {
    }
    resource function get lecturers/[string  staffNumber]() returns InlineResponse2001|http:NotFound {
    }
    resource function put lecturers/[string  staffNumber](@http:Payload LecturersStaffnumberBody payload) returns http:Ok|http:BadRequest|http:NotFound {
    }
    resource function delete lecturers/[string  staffNumber]() returns http:NoContent|http:NotFound {
    }
    resource function get courses/[string  courseCode]/lecturers() returns LecturersBody[]|http:NotFound {
    }
    resource function get offices/[string  officeNumber]/lecturers() returns LecturersBody[]|http:NotFound {
    }
}
