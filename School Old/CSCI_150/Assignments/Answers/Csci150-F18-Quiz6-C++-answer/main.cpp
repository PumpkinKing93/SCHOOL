//
//  main.cpp
//  CSci150-F17-Quiz7-answer
//
//  Created by Shih-Hsi Liu on 12/12/17.
//  Copyright © 2017 Shih-Hsi Liu. All rights reserved.
//

#include <iostream>
#include <vector>
#include "Student.h"
using namespace std;



int main(int argc, const char * argv[]) {
    Student* aStudent = new Student();
    Seminar* googleSeminar = new Seminar();
    Course* gooleMapAPI = new Course(googleSeminar);
    Seminar* facebookSeminar = new Seminar();
    Course* facebookAPI = new Course(facebookSeminar);
    googleSeminar->addCourse(gooleMapAPI);
    facebookSeminar->addCourse(facebookAPI);
    
    aStudent->enrollSeminar(googleSeminar);
    aStudent->enrollSeminar(facebookSeminar);
    aStudent->enrollSeminar(googleSeminar);
    return 0;
}
