import ballerina/http;

//Lecture record
public type Lecturer record {
    readonly string staffNumber;
    string staffName?;
    string title?;
    string email?;
    int officeNumber?;
    string officeLocation?;
};

//In-memory table to store lectures
public table<Lecturer> key(staffNumber) lecturerTable = table [
    {staffNumber: "101234569", staffName: "Roxxane Marie", title: "Ms", email: "rmarie@nust.na", officeNumber: 25, officeLocation: "PolyHeights"}
];

public type Course record {|
    # course code
    readonly string code;
    # course name
    string name;
    # point total from course
    int credit;
    # course topics
    string topics;
|};

public table<Course> key(code) courseTable = table [
    {code: "BSQ239s", name: "Basic Sofware Qualification", credit: 7, topics: "Computer Ethics, Basics of Cyber Court"},
    {code: "DSA342s", name: "Data System", credit: 2, topics: "Data Structure, Data functions"},
    {code: "MAB231s", name: "Mac Artificial Biotech", credit: 3, topics: "AI Basics, AI advance"},
    {code: "SAK233s", name: "System Architect Kulture", credit: 5, topics: "Back-end Design, System Audit"}
];

public type CreatedLecturers record {|
    *http:Created;
    Lecturer[] body;
|};

public type ErrorMessage record {|
    string message;
|};

public type ConflictingStaffNumbers record {|
    *http:Conflict;
    ErrorMessage body;
|};

public type ConflictingCourseNumbers record {|
    *http:Conflict;
    ErrorMessage body;
|};

public type InvalidStaffNumber record {|
    *http:NotFound;
    ErrorMessage body;
|};

public type InvalidCourseNumber record {|
    *http:NotFound;
    ErrorMessage body;
|};

public type CreatedCourses record {|
    *http:Created;
    Course[] body;
|};

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

service http:Service /lecturer on new http:Listener(9090) {
    //Get all lecturers
    resource function get lecturers() returns Lecturer[] {
        return lecturerTable.toArray();
    }
    //POST  a new lecturer
    resource function post lecturers(@http:Payload Lecturer[] payload) returns CreatedLecturers|ConflictingStaffNumbers {
        string[] conflictingStaffNumbers = from Lecturer lect in payload
            where lecturerTable.hasKey(lect.staffNumber)
            select lect.staffNumber;

        if conflictingStaffNumbers.length() > 0 {
            return <ConflictingStaffNumbers>{
                body: {
                    message: string `Error: Lecturer with staff number {conflictingStaffNumbers} already exists`
                }
            };
        } else {
            payload.forEach(lect => lecturerTable.add(lect));
            return <CreatedLecturers>{body: payload};
        }
    }

    // Get specific lecturer
    resource function get Lecturer/[string staffName]() returns Lecturer|InvalidStaffNumber {
        Lecturer? theLecturer = lecturerTable.get(staffName);

        if theLecturer == () {
            return <InvalidStaffNumber>{
                body: {
                    message: string `Lecturer with Lecturer name ${staffName} not found`
                }
            };
        } else {
            return theLecturer;
        }
    }

    // Update Lecturer information
    resource function put users/[string staffName](@http:Payload Lecturer payload) returns Lecturer|InvalidStaffNumber {
        Lecturer? theLecturer = lecturerTable.get(staffName);
        if theLecturer == () {
            return <InvalidStaffNumber>{
                body: {
                    message: string `Lecturer with Lecturer name ${staffName} not found`
                }
            };
        } else {
            string? Lecturername = payload.staffName;
            if Lecturername != () {
                theLecturer.staffName = Lecturername;
            }
            string? email = payload.email;
            if email != () {
                theLecturer.email = email;
            }
            return theLecturer;
        }
    }

    // Delete existing Lecturer
    resource function delete users/[string staffNumber]() returns http:NoContent|InvalidStaffNumber {
        Lecturer? theLecturer = lecturerTable.get(staffNumber);
        if theLecturer == () {
            return <InvalidStaffNumber>{
                body: {
                    message: string `Lecturer with Lecturer number ${staffNumber} not found`
                }
            };
        } else {
            http:NoContent noContent = {};
            return noContent;
        }
    }

    // Get All Courses
    resource function get course() returns Course[] {
        return courseTable.toArray();
    }

    // Insert a new course
    resource function post courses(@http:Payload Course[] payload) returns CreatedCourses|ConflictingCourseNumbers {

        string[] conflictingCourseNumbers = from Course cour in payload
            where courseTable.hasKey(cour.code)
            select cour.code;

        if conflictingCourseNumbers.length() > 0 {
            return <ConflictingCourseNumbers>{
                body: {
                    message: string `Error: Course with course number {conflictingCourseNumbers} already exists`
                }
            };
        } else {
            payload.forEach(cour => courseTable.add(cour));
            return <CreatedCourses>{body: payload};
        }
    }

    // Get specific Course
    resource function get course/[string courseName]() returns Course|InvalidCourseNumber {
        Course? theCourse = courseTable.get(courseName);

        if theCourse == () {
            return <InvalidCourseNumber>{
                body: {
                    message: string `Course with course name ${courseName} not found`
                }
            };
        } else {
            return theCourse;
        }
    }

    // Update course information
    resource function put course/[string courseCode](@http:Payload Course payload) returns InvalidStaffNumber|Course {
        Course? theCourse = courseTable.get(courseCode);

        if theCourse == () {
            return <InvalidStaffNumber>{
                body: {
                    message: string `Course with course code ${courseCode} not found`
                }
            };
        } else {
            string? coursename = payload.name;
            if coursename != () {
                theCourse.name = coursename;
            }
            int? coursecred = payload.credit;
            if coursecred != () {
                theCourse.credit = coursecred;
            }
            string? topic = payload.topics;
            if topic != () {
                theCourse.topics = topic;
            }
            return theCourse;
        }
    }

}



