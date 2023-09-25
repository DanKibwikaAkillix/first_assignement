
// Question 1: Restful APIs
// The problem centers on developing a Restful API for effectively managing staff, their offices, and 
// allocated courses within the Faculty of Computing and Informatics. These offices can 
// accommodate multiple lecturers. A lecturer is characterized by essential attributes, including a 
// staff number, office number, staff name, title, and a list of the courses they are teaching. 
// Additionally, a course is characterized by specific details such as the course name, course code, 
// and NQF (National Qualifications Framework) level.
// The API should include the following functionalities:
// • Add a new lecturer
// • Retrieve a list of all lecturers within the faculty.
// • Update an existing lecturer's information.
// • Retrieve the details of a specific lecturer by their staff number.
// • Delete a lecturer's record by their staff number.
// • Retrieve all the lecturers that teach a certain course.
// • Retrieve all the lecturers that sit in the same office.
// Note that the staff number should serve as a unique identifier for a lecturer.
// Your task is to define the API following the OpenAPI standard and implement the client and 
// service in the Ballerina language.

//  employee management system (EMS)

import ballerina/http;

public type EMSentry record {|


    readonly string staff_number;
    string office_number;
    string staff_name;
    string title;
    string[] Course;//use an array to store the specific information about the Courses 

    
|};

//create table to store real time data Upload
public final table<EMSentry > key(staff_number) staffTable = table [
    {staff_number:"A3345",      office_number:"203", staff_name:"Mr.Kapuire.G",  title:"Doctor in Software Engineering",  Course:["SVV","DBP", "WIL"]  },
     {staff_number:"FF54334",   office_number:"102", staff_name:"Mis.Josephina", title:"Lecturer at UNMA",                Course:["OPM"]  },
    {staff_number:"HGF0012",    office_number:"001", staff_name:"Mis.Peter",     title:"Flutter developer",               Course:["DST"]  },
    {staff_number:"DG33456",    office_number:"982", staff_name:"Mr.Wilfried",   title:"Senior Developer sat Jabu",       Course:["MCI","PGR", "DSA"]  }
    
];

// ERROR HANDLER while insertion occures 

public type ConflictingStaffCodeError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};


public type InvalidStaffCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};
// create Service 


service /staff on new http:Listener(9000) {

    //get resource 
	resource function get staff() returns EMSentry[] {
        return staffTable.toArray();
    }

//Reource get staff by Staff_number
    resource function get staff/[string staff_number]() returns EMSentry| InvalidStaffCodeError {
        EMSentry? emsEntry = staffTable[staff_number];
        if emsEntry is () {
            return {
                body: {
                    errmsg: string `Error while loading data "Invalid Staff Code": ${staff_number}`
                }
            };
        }
        return emsEntry;
    }

    // resource to add new Lecturer

    resource function post staff(@http:Payload EMSentry[] emsEntries)
                                    returns EMSentry[]|ConflictingStaffCodeError{

    string[] conflictingStaffCodes = from EMSentry emsEntry in emsEntries
        where staffTable .hasKey(emsEntry.staff_number)
        select emsEntry.staff_number;

    if conflictingStaffCodes.length() > 0 {
        return {
            body: {
                errmsg: string:'join(" ", "Conflicting StaffCode Codes:", ...conflictingStaffCodes)
            }
        };

    } else {
        emsEntries.forEach(emsEntry =>  staffTable.add(emsEntry));
        return emsEntries;
    }
}
 // Resource to delete a lecturer by staff_number
    resource function delete staff/[string staff_number]() returns ErrorMsg|InvalidStaffCodeError {
        EMSentry? emsEntry = staffTable[staff_number];
        if emsEntry is () {
            return {
                body: {
                    errmsg: string `Error while deleting data - Invalid Staff Code: ${staff_number}`
                }
            };
        }
        EMSentry _ = staffTable.remove(staff_number);
        return {
            errmsg: "Staff deleted successfully"
        };
    }

    // Resource to update a lecturer's information by staff_number
    resource function put staff/[string staff_number](@http:Payload EMSentry emsEntry) returns EMSentry|InvalidStaffCodeError {
        EMSentry? existingEntry = staffTable[staff_number];
        if (existingEntry is ()) {
            return {
                body: {
                    errmsg: string `Error while updating data - Invalid Staff Code: ${staff_number}`
                }
            };
        }
        
        // Update the existing entry with the new data
        existingEntry.office_number = emsEntry.office_number;
        existingEntry.staff_name = emsEntry.staff_name;
        existingEntry.title = emsEntry.title;
        existingEntry.Course = emsEntry.Course;
        
        return existingEntry;
    }
}

// Script to add new Staff ==>
//curl http://localhost:9000/namibia/universities/staff -d "[{\"staff_number\":\"23DEU\", \"office_number\":\"2234\", \"staff_name\":\"Mr.Amdrew\", \" title\":\"HoD\", \"Course\":\"MATH\"}]" -H "Content-Type: application/json"

