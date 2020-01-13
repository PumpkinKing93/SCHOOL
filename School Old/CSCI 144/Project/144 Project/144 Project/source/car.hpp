//
//  car.hpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#ifndef car_hpp
#define car_hpp

#include <stdio.h>
#include <iostream>	//get rid of the STD::
#include <thread>		//b*e able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string

using namespace std;

struct car {
	car(int carID, string interval, string direction);
	
	int carID;
	string interval;
	string direction;
	
//	thread(car(carID, interval, direction));
};

#endif /* car_hpp */
