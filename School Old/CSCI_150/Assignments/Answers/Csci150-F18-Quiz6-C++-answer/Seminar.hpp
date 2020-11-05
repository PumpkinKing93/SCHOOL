//
//  Seminar.hpp
//  CSci150-F17-Quiz7-answer
//
//  Created by Shih-Hsi Liu on 12/12/17.
//  Copyright © 2017 Shih-Hsi Liu. All rights reserved.
//

#ifndef Seminar_hpp
#define Seminar_hpp
#include "Course.hpp"
//#include "Student.h"
class Student;
//class Course;
class Seminar
{
private:
    //assume one seminar has one course only
    Course* course;
public:
    Seminar()
    {
        //course = new Course(this);
    }
    ~Seminar()
    {
        //delete course;
    }
    void addCourse(Course* aCourse)
    {
        course = aCourse;
    }
    bool enrollStudent(Student* aStudent, vector<Seminar*>* history)
    {
        bool eligibilityStatus = course->isStudentEligible(history);
        if (eligibilityStatus){
            history->push_back(this);
            course->enroll(aStudent);
        }
        return eligibilityStatus;
    }
};

#endif /* Seminar_hpp */
