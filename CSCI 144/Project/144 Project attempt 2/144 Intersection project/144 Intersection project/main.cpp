//
//  main.cpp
//  144 Intersection project
//
//  Created by Tyler Gillette on 11/20/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include <iostream>	//get rid of the STD::
#include <thread>		//be able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string
#include <chrono>
#include <unistd.h>
#include <pthread.h>

#define MAX 100

using namespace std;

mutex m;
condition_variable cv;
unique_lock<mutex> lck(m);
vector<string> carTime;
vector<string> carDir;
vector<bool> ready(MAX);
vector<thread> vts;

int tid = 0;
string release_direction;
string direction;

struct car {
	int carID;
	string interval;
	string direction;
	
	car(int carID, string interval, string direction): carID(carID), interval(interval), direction(direction){
	}
};

struct compareLane {
	bool operator()(car const& c1, car const& c2){
		return c1.interval < c2.interval;
	}
};

priority_queue<car, vector<car>, compareLane> cars;
priority_queue<car, vector<car>, compareLane> pqN;
priority_queue<car, vector<car>, compareLane> pqE;
priority_queue<car, vector<car>, compareLane> pqS;
priority_queue<car, vector<car>, compareLane> pqW;
vector<car> intersection;


						 
//void* release (){
//		while(!AllQueuesEmpty()){
//			for(int i = 0; i<4. ++i){
//				if (not conflicting with cars in intersection){
//					direction == ith direction;
//					cv.signal();
//					usleep();
//				}
//				sleep(100ms);
//			}
//		}
//	}
						 
//thread(*tid, &release);

//void* go (int interval, string direction){
//	//	based on direction =
//
//	cars.push(new car(tid, interval, direction));
//	while(!(cars.top()) && release_direction == direction){
//		cv.wait(lck);
//	}
//	myCar<-cars*.top();
//	cars.pop();
//	intersection.push(myCar);
//	sleep(5);
//	cout << "I'm Leaving" << endl;
//	intersection.pop();
//
//}

void readFile(int num){
	string dir;				//get the direction
	string line;			//store each line
	string file;			//file name
	ifstream myfile;	//file
	
	
	//which file to use?
	if(num == 1){
		file = "easy.txt";
	}
	else if (num == 2){
		file = "medium.txt";
	}
	else if (num == 3){
		file = "hard.txt";
	}
	else exit(1);   // call system to stop
	
	
	//check that file exists and opens
	if (!myfile)
	{
		cerr << "Unable to open file" << endl;
		exit(1);   // call system to stop
	}
	
	myfile.open(file);	//open the file for use
	
	
	while (getline (myfile,line)){
		
		size_t index = line.find(" ");
		string interval = line.substr(0,index);
		string direction = line.substr(index+1);
		carTime.push_back(interval);
		carDir.push_back(direction);
		
//		thread (tid+1, &go, interval, direction);
		
	}
	
	myfile.close();
	
	
	return;
}



						 
void makeCars(){
	
	for(int i = 0; i<carDir.size(); i++){
		car *carP = new car(i, carTime[i], carDir[i]);
		//		cout << carDir.size() << i << endl;
		cars.push(*carP);
		//		cout << cars.top().carID << endl;
	}
}

						 
						 
void going(){
	while (!cars.empty()) {
		//		thread thread_obj ();
		
		cout<<"Passed car#: "<<cars.top().carID<<" Time: "<<cars.top().interval<<" Dir: " << cars.top().direction <<endl;
		//		ready.at(x) = false;
		//		while (!ready.at(x))intersection.wait(mlock);
		//			cout << "thread " << x << " completed!" << endl;
		cars.pop();
		//		thread_obj.join();
	}
}

						 
						 
						 
						 


void theDriver(int num){
	readFile(num);
	makeCars();
	going();
}

int main() {
	int fileNum = 0;
	
	//ask the user which file they want to use.
	cout << "please select a file: " <<
	endl << "  0: exit" <<
	endl << "  1: easy" <<
	endl << "  2: medium" <<
	endl << "  3: hard" << endl;
	cin >> fileNum;
	
	theDriver(fileNum);
	
	
	
	return 0;
}
