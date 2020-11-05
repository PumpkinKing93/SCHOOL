//
//  lane.hpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#ifndef lane_hpp
#define lane_hpp

#include <stdio.h>
#include <stdio.h>
#include <iostream>	//get rid of the STD::
#include <thread>		//be able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string

#include "car.hpp"
using namespace std;

class lane {
public:

	condition_variable cv;
	mutex mlock;
	
	struct compareLane {
			bool operator()(car const& c1, car const& c2)
			{
					return c1.interval < c2.interval;
			}
	};
	
//	string arr[ROW][COL]
	
	vector<car> waiting;
	
	priority_queue<car, vector<car>, compareLane> cars;
	
	void wait(car carP);
	void going();
	
		

};

#endif /* lane_hpp */
