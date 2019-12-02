//
//  main.cpp
//  144 StopLight Project
//
//  Created by Tyler Gillette on 11/01/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//  Based on Sudo code given in class
//

#include <chrono>							//use time functions
#include <ctime>							//timer
#include <condition_variable>	//create and use conditional variables
#include <deque>							//clear queue
#include <fstream>						//write to a file
#include <iomanip>
#include <iostream>						//read and write files
#include <map>								//use map functions
#include <mutex>							//use thread locks and mutex
#include <queue>							//use pq's
#include <sstream>						//use str()
#include <string>							//more file functions
#include <thread>							//use thread functions
#include <time.h>       			//clock_t, clock, CLOCKS_PER_SEC 
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
	~Compare() { };
};
//========================================================================================

//=================================Functions=============================================

// define all the functions for use later
//void release();
//void wait(int, string);
void go(string, priority_queue<Car*, vector<Car*>, Compare>&, int, string);
//=======================================================================================


//=================================Definitions=============================================
//NESW
// Create all the priority queues for the lanes
priority_queue<Car*, vector<Car*>, Compare> Empty;	//Empty lane place holder just in case
priority_queue<Car*, vector<Car*>, Compare> North;	//North lane for all N variations
priority_queue<Car*, vector<Car*>, Compare> East;	//East lane for all E variations
priority_queue<Car*, vector<Car*>, Compare> South;	//South lane for all S variations
priority_queue<Car*, vector<Car*>, Compare> West;	//West lane for all W variations
priority_queue<Car*, vector<Car*>, Compare> activeLane; //the lane that moves the cars
queue<Car*> intersection;	//queue to track all the cars in the intersection
condition_variable cv;	//cv to check if its clear
mutex laneLocker;	//lock the lane so that it doesnt crash
vector<thread> cars;	//keep track of all the running threads
string currDir = "";	//keep track of the current direction thats going
//==========================================================================================


//=================================Func Def=============================================

void wait(int interval, string direction){
	if(direction[0] == 'N'){	//check the first character of the string and sort into pq
		go("North", North, interval, direction);
	}
	if(direction[0] == 'E'){	//check the first character of the string and sort into pq
		go("East", East, interval, direction);
	}
	if(direction[0] == 'S'){	//check the first character of the string and sort into pq
		go("South", South, interval, direction);
	}
	if(direction[0] == 'W'){	//check the first character of the string and sort into pq
		go("West", West, interval, direction);
	}
	return;
}

void release() {
	while ((!North.empty() || !South.empty()) || (!East.empty() || !West.empty())) {
		if (!North.empty()) {	//check that North queue has cars
			if(currDir != "W" && currDir != "E") {	//check that they are not
				currDir = "N";	//update the currDir string for later
				cout << "cv notify: N" << endl;
				cv.notify_one();	//notify the queue
			}
			cout << "error:  1" << endl;
		}
		if (!East.empty()) {	//check that East queue has cars
			if (currDir != "N" && currDir != "S") {
				currDir = "E";	//update the currDir string for later
				cout << "cv notify: E" << endl;
				cv.notify_one();	//notify the queue
			}
			cout << "error:  2" << endl;
		}
		if (!South.empty()) {	//check that South queue has cars
			if (currDir != "W" && currDir != "E") {
				currDir = "S";	//update the currDir string for later
				cout << "cv notify: S" << endl;
				cv.notify_one();	//notify the queue
			}
			cout << "error:  3" << endl;
		}
		if (!West.empty()) {	//check that West queue has cars
			if (currDir != "N" && currDir != "S") {
				currDir = "W";	//update the currDir string for later
				cout << "cv notify: W" << endl;
				cv.notify_one();	//notify the queue
			}
			cout << "error:  4" << endl;
		}
	}
	return;
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
//	sleep(1);
	intersection.push(tempCar);
	cout << "Direction: " << tempCar->direction.c_str() << " ID: " << tempCar->interval << " Time: " << tempCar->interval <<  endl;
	intersection.pop();
	return;
}

//======================================================================================


int main() {
	string line;	//get each line
	string filePath;	//store the file path
	int fileNum;	//choose which file
	int tcount = 1;
	
	time_t start = time(0);
	
	
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
	
	
	while (getline (file,line)){
		size_t index = line.find(" ");
		string interval = line.substr(0,index);
		string direction = line.substr(index+1);
		
		currDir = direction;
		
		sleep(1);
		cars.push_back(thread(go, direction, ref(activeLane), stoi(interval), direction)); //driver
		cout << "Car Thread Created: " << tcount << endl;	//print that the car threads are being created
		tcount++;
	}
	
	file.close();
	
	thread releaseCars(release);	//create threads to call the release function
	
	releaseCars.join();	//the sorted car threads are joined here
	for (int i = 0; i < cars.size(); ++i) {
		cars[i].join();	//join the car threads
		cout << "Thread joined: " << i+1 << endl;	//print that the threads are joined for feedback
	}
	
	double seconds_since_start = difftime( time(0), start);	//end the timer and do the math to get final time
	cout << "Total Time: " << seconds_since_start << "s" << endl;	//print the final time in seconds
	
	//clean up
	Empty = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
	North = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
	East = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
	South = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
	West = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
	activeLane = priority_queue<Car*, vector<Car*>, Compare>();	//reset pq
  intersection = queue<Car*>();	//reset queue
	cars.erase(cars.begin(),cars.end());	//delete vector
	currDir.clear(); //clear the currDir String
	
	return 0;
}
