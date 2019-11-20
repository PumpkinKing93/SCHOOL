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

using namespace std;

mutex m;
condition_variable cv;
vector<string> carTime;
vector<string> carDir;


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
				
	myfile.close();

	
	return;
	}
}

struct car {
	
	int carID;
	string interval;
	string direction;
	
	car(int carID, string interval, string direction): carID(carID), interval(interval), direction(direction){
		//	thread(car(carID, interval, direction));
	}
};

struct compareLane {
		bool operator()(car const& c1, car const& c2)
		{
				return c1.interval < c2.interval;
		}
};


priority_queue<car, vector<car>, compareLane> cars;


void makeCars(){
	
	for(int i = 0; i<carDir.size(); i++){
		car *carP = new car(i, carTime[i], carDir[i]);
		cars.push(*carP);
	}
}

void theDriver(int num){
	readFile(num);
	makeCars();
	
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
