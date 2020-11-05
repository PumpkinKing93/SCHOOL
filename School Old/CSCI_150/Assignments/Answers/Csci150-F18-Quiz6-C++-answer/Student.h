//
//  Student.hpp
//  CSci150-F17-Quiz7-answer
//
//  Created by Shih-Hsi Liu on 12/12/17.
//  Copyright © 2017 Shih-Hsi Liu. All rights reserved.
//

#ifndef Student_hpp
#define Student_hpp
#include <vector>
#include "Seminar.hpp"
using namespace std;

class Student
{
private:
    vector<Seminar*>* history;
    
public:
    Student()
    {
        history = new vector<Seminar*>();
    }
    ~Student()
    {
        delete history;
    }
    //this is based on digram
    //not a good design (learned in CSCi 152
    vector<Seminar*>* getSeminarHistory()
    {
        return history;
    }
    void enrollSeminar(Seminar* interestedSeminar)
    {
        bool enrollmentStatus = interestedSeminar->enrollStudent(this, history);
        if (enrollmentStatus)
            cout<<"enrolled successfully"<<endl;
        else
            cout<<"you took this cours before"<<endl;
    }
    
    
};

#endif /*Student_hpp */
