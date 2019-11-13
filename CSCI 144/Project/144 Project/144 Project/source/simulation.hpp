//
//  simulation.hpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#ifndef simulation_hpp
#define simulation_hpp

#include <stdio.h>
#include <stdio.h>
#include <iostream>	//get rid of the STD::
#include <thread>		//be able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string

#include "trafficLight.hpp"
#include "car.hpp"
#include "lane.hpp"

using namespace std;

class simulation {
	public:
	trafficLight light1;
	
	vector<string> carTime;
	vector<string> carDir;
	
	void readFile(int num);
	void makeCars();
	
	void start();
	void printDirVect();
	void printTimeVect();


};

#endif /* simulation_hpp */
