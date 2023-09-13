public type LecturersBody record {
    string staffNumber?;
    string officeNumber?;
    string staffName?;
    string title?;
    LecturersCourses[] courses?;
};

public type InlineResponse2001 record {
    string staffNumber?;
    string officeNumber?;
    string staffName?;
    string title?;
    record {string courseName?; string courseCode?; int nqfLevel?;}[] courses?;
};

public type InlineResponse200 record {
    string staffNumber?;
    string officeNumber?;
    string staffName?;
    string title?;
    LecturersCourses[] courses?;
};

public type LecturersStaffnumberBody record {
    string officeNumber?;
    string staffName?;
    string title?;
    LecturersCourses[] courses?;
};

public type LecturersCourses record {
    string courseName?;
    string courseCode?;
    int nqfLevel?;
};
