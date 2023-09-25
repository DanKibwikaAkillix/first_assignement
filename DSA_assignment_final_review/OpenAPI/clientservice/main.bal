import ballerina/io;

public function main() returns error? {
    Client httpClient = check new ();

    
    io:println("\n\n\nCREATING 3 NEW LECTURER RECORDS");
    Lecturer lecturer1 = {full_name: "R Musutua",office_number: "A1",staff_number: "1",list_of_courses: ["DSA101", "PRG101"]};
    Lecturer lecturer2 = {full_name: "S Trjiraso",office_number: "A1",staff_number: "2",list_of_courses: ["DSA101", "DTA101"]};
    Lecturer lecturer3 = {full_name: "J Muntuumo",office_number: "A2",staff_number: "3",list_of_courses: ["DSA101", "DPG101"]};
    _ = check httpClient->/newlecturer.post(lecturer1);
    _ = check httpClient->/newlecturer.post(lecturer2);
    _ = check httpClient->/newlecturer.post(lecturer3);

    var lecturers = check httpClient->/lecturers;
    foreach var l in lecturers {
        io:println(l);
    }



    io:println("\n\n\nGETTING LECTURERS BY THEIR STAFF NUMBER");
    var l1 = check httpClient->/lecturerbystaffnumber/["1"];
    var l2 = check httpClient->/lecturerbystaffnumber/["2"];
    var l3 = check httpClient->/lecturerbystaffnumber/["3"];
    io:println(l1.toString());
    io:println(l2.toString());
    io:println(l3.toString());



    io:println("\n\n\nGETTING LECTURERS BY THEIR OFFICE NUMBER");
    var A1 = check httpClient->/lecturersbyofficenumber/["A1"];
    var A2 = check httpClient->/lecturersbyofficenumber/["A2"];
    io:println(A1.toString());
    io:println(A2.toString());



    io:println("\n\n\nGETTING LECTURERS BY COURSE CODE");
    var DSA101 = check httpClient->/lecturersbycoursecode/["DSA101"];
    var PRG101 = check httpClient->/lecturersbycoursecode/["PRG101"];
    var DPG101 = check httpClient->/lecturersbycoursecode/["DPG101"];
    io:println(DSA101.toString());
    io:println(PRG101.toString());
    io:println(DPG101.toString());



    io:println("\n\n\nUPDATING LECTURER DETAILS");
    Lecturer u1 = {full_name: "R Nashandi",office_number: "A1",staff_number: "1",list_of_courses: ["DSA101", "PRG101"]};
    Lecturer u2 = {full_name: "S Nashandi",office_number: "A1",staff_number: "2",list_of_courses: ["DSA101", "DTA101"]};
    Lecturer u3 = {full_name: "J Nashandi",office_number: "A2",staff_number: "3",list_of_courses: ["DSA101", "DPG101"]};
    _ = check httpClient->/updatelecturerdetails.put(u1);
    _ = check httpClient->/updatelecturerdetails.put(u2);
    _ = check httpClient->/updatelecturerdetails.put(u3);
    lecturers = check httpClient->/lecturers;
    foreach var l in lecturers {
        io:println(l);
    }



    io:println("\n\n\nDELETING LECTURERS");
    var deleted1 = check httpClient->/deletelecturer/["1"].delete;
    var deleted2 = check httpClient->/deletelecturer/["2"].delete;
    io:println(deleted1.toString() + "\n" + deleted2.toString());



    io:println("\n\n\nFETCHING ALL LECTURERS");
    lecturers = check httpClient->/lecturers;
    foreach var l in lecturers {
        io:println(l);
    }

}
