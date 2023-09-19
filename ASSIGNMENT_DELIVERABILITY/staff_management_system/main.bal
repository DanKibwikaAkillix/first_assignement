import ballerina/http;

public type StaffEntry record {|

    readonly string staff_number;
    string staff_name;
    int office_number;
    string title;

|};

 // Error hanlder for Adding staff 

    public type ConflictingSatffNumberError record {|

        *http:Conflict;
        ErrorMsg body;

    |};

    public type InvalidStaff_numberError record {|
    *http:NotFound;
    ErrorMsg body;
    |};

    public type ErrorMsg record {|
    
        string errmsg;
    |};



public final table<StaffEntry> key(staff_number) staffTable = table [
        {staff_number: "12HSD",  staff_name: "Chadrack Mutombo",  office_number: 222, title: "Course Coodinator"},
        {staff_number: "22AABC", staff_name: "Dan Kibwika",       office_number: 212, title: "Lecturer"},
        {staff_number: "23JBC",  staff_name: "Chantelle VanCk",   office_number: 923, title: "lecturer assistant"},
        {staff_number: "42BBC",  staff_name: "Honore Kayumba",    office_number: 454, title: "Course Coodinator"},
        {staff_number: "00AIA",  staff_name: "Dino Almiral",      office_number: 101, title: "Lecturer"},
        {staff_number: "02AKB",  staff_name: "Michee Kashale",    office_number: 303, title: "lecturer assistant"}
      
];


   


service /staffMangement/staff on new http:Listener(9000) {

    // Resource to get all the staff details 
	resource function get staff() returns StaffEntry[] {
        return staffTable.toArray();
    }


    // Resource to get Staff by Key 
        resource function get staff/[string staff_number]() returns StaffEntry|InvalidStaff_numberError {
        StaffEntry? staffEntry = staffTable[staff_number];
        if staffEntry is () {
            return {
                body: {
                    errmsg: string `Invalid Staff number Code: ${staff_number}`
                }
            };
        }
        return staffEntry;
    }


    // Resource to add Staff by staff_number
    resource function post staff(@http:Payload StaffEntry[] staffEntries) returns StaffEntry[]|ConflictingSatffNumberError  {

    string[] conflictingISOs = from StaffEntry staffEntry in staffEntries
        where staffTable.hasKey(staffEntry.staff_number)
        select staffEntry.staff_number;

    if conflictingISOs.length() > 0 {
        return {
            body: {
                errmsg: string:'join(" ", "Conflicting ISO Codes:", ...conflictingISOs)
            }
        };
    } else {
        staffEntries.forEach(covdiEntry => staffTable.add(covdiEntry));
        return staffEntries;
    }
}

}


