import ballerina/io;
import ballerina/http;


public type courseEntry record {|

    readonly string courseCode;
    string course_name;
    int nqf_level;

|};

 // Error hanlder for Adding course

    public type ConflictingCourseCodeError record {|

        *http:Conflict;
        ErrorMsg body;

    |};

    public type InvalidCourse_codeError record {|
    *http:NotFound;
    ErrorMsg body;
    |};

    public type ErrorMsg record {|
    
        string errmsg;
    |};



public final table<courseEntry> key(courseCode) courseTable = table [
        {courseCode: "DSA612S",  course_name: "Distributed Systems And Applications",  nqf_level: 7},
        {courseCode: "DTA621S",  course_name: "Data Analytics",                        nqf_level: 7},
        {courseCode: "OPS611S",  course_name: "Operating Systems",                     nqf_level: 7},
        {courseCode: "PTM721S",  course_name: "Project Management",                    nqf_level: 7},
        {courseCode: "SYD611S",  course_name: "Sustainability Development",            nqf_level: 7},
        {courseCode: "CTE711S",  course_name: "Compiler Techniques",                   nqf_level: 7}
      
];



service /courseMangement/course on new http:Listener(9000) {

    // Resource to get all the courses details 
	resource function get courses() returns courseEntry[] {
        return courseTable.toArray();
    }


    // Resource to get Course by Key 
        resource function get course/[string course_code]() returns courseEntry|InvalidCourse_codeError {
        courseEntry? courseEntry = courseTable[course_code];
        if courseEntry is () {
            return {
                body: {
                    errmsg: string `Invalid Course Code: ${course_code}`
                }
            };
        }
        return courseEntry;
    }


    // Resource to add Course by course_code
    resource function post course(@http:Payload courseEntry[] courseEntries) returns courseEntry[]|ConflictingCourseCodeError  {

    string[] conflictingISOs = from courseEntry courseEntry in courseEntries
        where courseTable.hasKey(courseEntry.courseCode)
        select courseEntry.courseCode;

    if conflictingISOs.length() > 0 {
        return {
            body: {
                errmsg: string:'join(" ", "Conflicting ISO Codes:", ...conflictingISOs)
            }
        };
    } else {
        courseEntries.forEach(courseEntry => courseTable.add(courseEntry));
        return courseEntries;
    }
}

}
