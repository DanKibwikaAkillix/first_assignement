isolated service class StaffRepository {
    private table<Lecturer> key(staff_number) lecturers = table [];
    private table<Office> key(office_number) offices = table [
        {office_number: "A1", list_of_staff_numbers: []},
        {office_number: "A2", list_of_staff_numbers: []}
    ];
    private table<Course> key(course_code) courses = table [
        {course_code: "DSA101", course_name: "Distributed Systems and Algorithms", nqf_level: 7},
        {course_code: "PRG101", course_name: "Programming 1", nqf_level: 7},
        {course_code: "DTA101", course_name: "Data Analytics", nqf_level: 7},
        {course_code: "DPG101", course_name: "Database Programming", nqf_level: 7}
    ];
    
    isolated function getLecturers() returns Lecturer[]{
        Lecturer[] _lecturers;
        lock{
            _lecturers = self.lecturers.clone().toArray();
        }
        return _lecturers;
    }

    isolated function setLecturer(Lecturer _lecturer) returns string{
        lock{
            if(self.lecturers.hasKey(_lecturer.staff_number)){
                return "badrequest";
            }
            if!(self.offices.hasKey(_lecturer.office_number ?: "")){
                return "Office does not exist";
            }
            error? add_result = self.lecturers.add(_lecturer.clone());
            Office office = self.offices.get(_lecturer.office_number ?: "");
            office.list_of_staff_numbers.push(_lecturer.staff_number);
            self.offices.put(office);
            return (add_result is error) ? "" : _lecturer.office_number ?: "";
        }
    }

    isolated function getLecturerByStaffNumber(string staff_number) returns Lecturer|error{
        lock{
            if(self.lecturers.hasKey(staff_number)){
                return self.lecturers.get(staff_number).clone();
            }
            return error("");
        }
    }

    isolated function updateLecturer(Lecturer _lecturer) returns Lecturer|error{
        lock{
            if(self.lecturers.hasKey(_lecturer.staff_number)){
                error? put_result = self.lecturers.put(_lecturer.clone());
                return (put_result is error) ? error("") : _lecturer.clone();
            }
            return error("notfound");
        }
    }

    isolated function getLecturersByOfficeNumber(string office_number) returns Lecturer[]|error{
        lock{
            Lecturer[] _lecturers = [];
            string[] keys;
            if(!self.offices.hasKey(office_number)){
                return error("notfound");
            }
            keys = self.offices.get(office_number).list_of_staff_numbers.clone();
            foreach string staff_number in keys {
                Lecturer? lecturer = self.lecturers[staff_number];
                if (lecturer != null) {
                    _lecturers.push(lecturer);
                }
            }
            return _lecturers.clone();
        }
    }

    isolated function getLecturersByCourseCode(string course_code) returns Lecturer[]|error{
        lock{
            return (from Lecturer l in self.lecturers.clone()
                where l.list_of_courses.indexOf(course_code) != ()
                select l).clone().toArray();
        }
    }

    isolated function deleteLecturer(string staff_number) returns Lecturer|error{
        lock{
            if(!self.lecturers.hasKey(staff_number)){
                return error("");
            }
            return self.lecturers.remove(staff_number).clone();
        }
    }
}