// import ballerina/http;
// type Student record {
//     readonly string studentId;
//     string name;
//     int age;
// };
// table<Student> key(studentId) students = table [];
// service /students on new http:Listener(8080) {
//     resource function get renderStudentsPage() returns http:Response {
//         // Create an HTML response
//         string tableHtml = "<table border='1'><tr><th>Student ID</th><th>Name</th><th>Age</th></tr>";

//         students.forEach(function (Student student) {
//             tableHtml += "<tr><td>" + student.studentId + "</td><td>" + student.name + "</td><td>" + student.age.toString() + "</td></tr>";
//         });

//         tableHtml += "</table>";

//         string htmlContent = string `
//             <!DOCTYPE html>
//             <html>
//             <head>
//                 <title>Student Table</title>
//             </head>
//             <body>
//                 <h1>Student Records</h1>
//                 ${tableHtml}
//             </body>
//             </html>
//         `;

//         http:Response response = new;
//         response.setTextPayload(htmlContent);
//         response.setHeader("Content-Type", "text/html");

//         return response;
//     }
// }