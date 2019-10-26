//
//  Course.hpp
//  CSci150-F17-Quiz7-answer
//
//  Created by Shih-Hsi Liu on 12/12/17.
//  Copyright © 2017 Shih-Hsi Liu. All rights reserved.
//

//#ifndef Course_hpp
//#define Course_hpp
//#include "Student.h"
#include <vector>

using namespace std;
class Seminar;
class Student;
class Course
{
private:
    Seminar* hostSeminar;
    vector<Student*>* roster;
public:
    Course(){}
    Course(Seminar* aSeminar)
    {
        hostSeminar = aSeminar;
        roster = new vector<Student*>();
    }
    ~Course()
    {
        delete roster;
    }
    void setSeminar(Seminar* aSeminar)
    {
        hostSeminar= aSeminar;
    }
    bool isStudentEligible(vector<Seminar*>* seminarHistory)
    {
     
        for (int i =0; i< seminarHistory->size(); i++)
            if (seminarHistory->at(i) == hostSeminar)
                return false;
        return true;
    }
    void enroll(Student* aStudent)
    {
        roster->push_back(aStudent);
    }
    
};
//#endif /* Course_hpp */
