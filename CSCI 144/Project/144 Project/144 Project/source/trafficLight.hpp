//
//  trafficLight.hpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#ifndef trafficLight_hpp
#define trafficLight_hpp

#include <stdio.h>
#include <iostream>	//get rid of the STD::
#include <thread>		//be able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string
#include<algorithm> //change vectors
#include <list>

#include "lane.hpp"
using namespace std;

class trafficLight{
public:

	
	lane North;
	lane East;
	lane South;
	lane West;
	
	void sortCar(car carP);
	void light();
	void isSafe(vector<car> *vect);
	
};

#endif /* trafficLight_hpp */
