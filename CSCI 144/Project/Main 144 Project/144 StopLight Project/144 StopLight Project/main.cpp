//
//  main.cpp
//  144 StopLight Project
//
//  Created by Tyler Gillette on 11/01/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//  Based on Sudo code given in class
//

#include <chrono>							//use time functions
#include <condition_variable>	//create and use conditional variables
#include <fstream>						//write to a file
#include <iomanip>
#include <iostream>						//read and write files
#include <map>								//use map functions
#include <mutex>							//use thread locks and mutex
#include <queue>							//use pq's
#include <sstream>						//use str()
#include <string>							//more file functions
#include <thread>							//use thread functions
#include <unistd.h>
#include <vector>							//use vectors

using namespace std;					//get rid of the STD::

// create the car object with the time and direction similar to sudo code
//=================================Structures=============================================
struct Car {
	int interval;
	string direction;
	
	Car(int interval, string direction) {
		this->interval = interval;
		this->direction = direction;
	}
	~Car() { };
};

struct Compare {
	bool operator()(Car* const& p1, Car* const& p2) {
		return p1->interval > p2->interval;
	}
};
//========================================================================================

//=================================Functions=============================================

// define all the functions for use later
void release();
void wait(int, string);
void go(string, priority_queue<Car*, vector<Car*>, Compare>&, int, string);
//=======================================================================================


//=================================Definitions=============================================

// Create all the priority queues for the lanes
priority_queue<Car*, vector<Car*>, Compare> Empty;	//Empty lane place holder just in case
priority_queue<Car*, vector<Car*>, Compare> North;	//North lane for all N variations
priority_queue<Car*, vector<Car*>, Compare> South;	//South lane for all S variations
priority_queue<Car*, vector<Car*>, Compare> West;	//West lane for all W variations
priority_queue<Car*, vector<Car*>, Compare> East;	//East lane for all E variations
priority_queue<Car*,vector<Car*>,Compare> activeLane; //the lane that moves the cars
queue<Car*> intersection;	//queue to track all the cars in the intersection
condition_variable cv;	//cv to check if its clear
mutex laneLocker;	//lock the lane so that it doesnt crash
vector<thread> cars;	//keep track of all the running threads
string currDir = "";	//keep track of the current direction thats going
//==========================================================================================


//=================================Func Def=============================================

void wait(int interval, string direction){
	if(direction[0] == 'N'){
		go("North", North, interval, direction);
	}
	if(direction[0] == 'E'){
		go("East", East, interval, direction);
	}
	if(direction[0] == 'S'){
		go("South", South, interval, direction);
	}
	if(direction[0] == 'W'){
		go("West", West, interval, direction);
	}
	return;
}

void release() {
	while (true) {
		if (!North.empty()) {	//check that North queue has cars
			if(currDir != "W" && currDir != "E") {	//check that they are not
				currDir = "N";	//update the currDir string for later
				cv.notify_one();	//notify the queue
			}
			
		}
		if (!East.empty()) {	//check that East queue has cars
			if (currDir != "N" && currDir != "S") {
				currDir = "E";	//update the currDir string for later
				cv.notify_one();	//notify the queue
			}
		}
		if (!South.empty()) {	//check that South queue has cars
			if (currDir != "W" && currDir != "E") {
				currDir = "S";	//update the currDir string for later
				cv.notify_one();	//notify the queue
			}
		}
		if (!West.empty()) {	//check that West queue has cars
			if (currDir != "N" && currDir != "S") {
				currDir = "W";	//update the currDir string for later
				cv.notify_one();	//notify the queue
			}
		}
	}
}



void go(string dir, priority_queue<Car*,vector<Car*>,Compare>& activeLane, int interval, string direction) {
	
	Car* newCar = new Car(interval, direction);
	activeLane.push(newCar);
	
	unique_lock<mutex> lock(laneLocker);
	while (activeLane.top() != newCar && currDir != newCar->direction) {
		cv.wait(lock);
	}
	
	Car* tempCar = activeLane.top();
	activeLane.pop();
	intersection.push(tempCar);
	sleep(1);
	//	•	Direction ID # car intervald intersection (e.g., West #3 car interval)
	//	•	Direction ID # car left intersection (e.g., West #3 car left intersection)
	//	printf("%s: %i   Direction: %s\n", d.c_str(), tempCar->interval, tempCar->direction.c_str());
	cout << dir.c_str() << ": " << "Direction: " << dir.c_str() << " " << tempCar->interval << " " << tempCar->direction.c_str() << endl;
	intersection.pop();
}
//======================================================================================


int main() {
	string line;	//get each line
	string filePath;	//store the file path
	int fileNum;	//choose which file
	
	//ask the user which file they want to use.
	cout << "please select a file: " <<
	endl << "  0: exit" <<
	endl << "  1: easy" <<
	endl << "  2: medium" <<
	endl << "  3: hard" << endl;
	cin >> fileNum;
	
	//which file to use?
	if(fileNum == 1){
		filePath = "easy.txt";	//choose the easy sample
	}
	else if (fileNum == 2){
		filePath = "medium.txt";	//choose the medium sample
	}
	else if (fileNum == 3){
		filePath = "hard.txt";		//choose the difficult sample
	}
	else exit(1);   					// call system to stop
	
	ifstream file(filePath);	//read the file from the user selection
	
	thread releaseCars(release);	//create threads to call the release function
	
	while (getline (file,line)){
		size_t index = line.find(" ");
		string interval = line.substr(0,index);
		string direction = line.substr(index+1);
		
		cars.push_back(thread(go,
													ref(interval),
													ref(direction))); //driver
		cout << "Thread Created" << endl;
	}
	file.close();
	
	releaseCars.join();
	for (int i = 0; i < cars.size(); ++i) {
		cars[i].join();
	}
	
	return 0;
}
