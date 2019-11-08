//DUE 12/1/2019 at 11:59PM
//Description: in this project, you will implement an intelligent traffic light system where cars arrive at an intersection towards West, East, South, North,  West-North (towards West but makes a turn to North), West-South, East-North, East-South, South-West, South-East, North-West, North-East directions.
//Your program should enforce the requirement that no two or more cars enter the intersection with "conflicting" directions. directions that conflict with each other include, for example, North and East, South and West, North-West and South. However, notice that North and South does not conflict. Similarly, North-West and South-East does not conflict. The goal of the solution, therefore, is to try to minimum the total time passing the intersection given any input of arriving cars.
//Understanding that multi-threading concurrency has the potential of providing maximum potential simultaneous operation while ensuring mutual exclusion, we can model each car arriving as a thread and the intersection as the critical section. Upon the arrival of a car, we create a new thread and pass the direction as the argument. There should be four queues that manage all the four directions as requests to pass the critical section. All threads should be blocked while waiting for conditions to pass the critical section. An additional thread (could be just main thread) should check all Head-of-the-Line queued threads understand if it should signal threads in certain directions. There are two conditions to wait for a new car thread: (1) if it's not the head-of-line thread for its direction queue; (2) if it's not allowed to pass the intersection. A sleep time of 5 seconds should be used to simulate that a car takes time to pass the intersection.
//Your program should display the following events on screen:
//	•	Thread creation
//	•	Direction ID # car arrived intersection (e.g., West #3 car arrived)
//	•	Direction ID # car left intersection (e.g., West #3 car left intersection)
//At the end, your program should print out the total time taken for all cars to pass the intersection.
//Input File: three sample inputs (simple,  medium, difficult) in the following format will be provided:
//time, direction
//0, N
//2, W
//2, E

//Bonus (15%): your program allows N (configurable, 10 as default) cars in one direction to go. In this case, cars do not wait for the previous one to leave the intersection (5 seconds). Instead, the waiting time will be 1 second.
//Testing: Your program should run forever until all cars pass the intersection.
//Cygwin compilation: "g++ -std=c++11 sample.cpp -lpthread"
//Project Report: a max of 2-page brief description of the results (total time) on three sample inputs. You should briefly justify the result based on your observation and analysis. If you implement the bonus part, you should present and justify your result in the report too.
//Submission: One zip file containing the following should be submitted:
//	•	All source code
//	•	Project report (2-page max)
//	•	README that "clearly" specify
//	◦	Running environment: Cygwin, Linux, Mac
//	◦	Compiler: C++11 (must be compatible)
//	◦	commands that compile and run your program
//	◦	Bonus part (if any) you have implemented

//  main.cpp
//  144 Project
//
//  Created by Tyler Gillette on 9/16/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include <iostream>	//get rid of the STD::
#include <thread>		//be able to use threads keyword
#include <fstream>	//write to a file
#include <string>  	//read from a file
#include <vector> 	//use vectors
#include <queue>		//create queues for directions
#include <sstream>	//get individual chars from a string
#include <map>
using namespace std;


//======================================Global======================================//
vector<int> headOfTraffic; //Stores the positions of the directions. If (0) then there are no cars. Otherwise, 1, 1st ... n, nth in line.
vector<queue<clock_t> > allCarsQueue; //place to store ALL THE CARS, sorted by direction, and storing the cars' arrival times.
vector<long double> carsPastIntersection; //analogous to a more broadly used timeDifferences in stopsign.cpp
//======================================Global end======================================//


//======================================Locks======================================//
pthread_mutex_t carsLock = PTHREAD_MUTEX_INITIALIZER;
mutex headOfTrafficLock;
pthread_mutex_t carPastIntersectionLock = PTHREAD_MUTEX_INITIALIZER;
//======================================Locks end======================================//


//======================================classes======================================//

//======================================classes end======================================//


//======================================functions======================================//
void readFile(int num, vector<string> &carTime, vector<string> &carDir
){
	//variables
	int count = 0;		//counter
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
	
	
	 myfile.open(file);	//open the file for use

	
	//check that file exists and opens
  if (!myfile)
  {
		cerr << "Unable to open file" << endl;
		exit(1);   // call system to stop
	}
	
			while (getline (myfile,line)){
				
					size_t index = line.find(" ");
					string interval = line.substr(0,index);
					string direction = line.substr(index+1);
				
					carTime.push_back(interval);
					carDir.push_back(direction);
					
				
				if (count >= 5000){
					cerr << "file size to large. Must be less than 5000 lines." << endl;
					exit(1);   // call system to stop
				}
				count++;
			}
		
				
	myfile.close();

	
	return;
}



void printSVector(vector<string> &vect){
	for (auto i: vect)
  cout << i << endl;
//	cout << i << ' ';
	return;
}

void printIVector(vector<int> &vect){
	
	for (auto i: vect)
  cout << i << endl;
//	cout << i << ' ';
	return;
}

void threadHandler(){
		thread threadObj([] {
			for (int i = 0; i < 10; i++)
				cout << "Thread creation: " << i << endl;
		});
	
		for (int i = 0; i < 10; i++)
			cout << "Display From Main Thread" << endl;
	
		threadObj.join();
		cout << "Exiting from Main Thread" << endl;
}

void trafficLigh(vector<string> &carTime, vector<string> &carDir){
	int i = 0;
	
	for(i=0; carDir.size()>i; i++){
		cout << "Car will arive in: " << carTime[i] << "s" << endl;
		cout << " and will be heading: " << carDir[i] << "." << endl << endl;
		
		if (carDir[i] == "N" || carDir[i] == "S"){
			if (carDir[i+1] != "E" || carDir[i+1] != "W")
			cout << "N or S" << endl;
		}
		
		if (carDir[i] == "E" || carDir[i] == "W"){
			if (carDir[i+1] != "N" || carDir[i+1] != "S")
			cout << "E or W" << endl;
		}
		
		
		}//end for
}//end func.

//======================================functions end======================================//


//======================================main======================================//
int main()
{
	//declare variables
	int fileNum = 0;
	vector <string> carTime;
	vector <string> carDir;
//	vector<string> cars;
	

	//ask the user which file they want to use.
	cout << "please select a file: " <<
	endl << "  0: exit" <<
	endl << "  1: easy" <<
	endl << "  2: medium" <<
	endl << "  3: hard" << endl;
	cin >> fileNum;
	


	//function calls
	readFile(fileNum, carTime, carDir);
	
//print functions
//	cout << endl << "car Direction:" << endl;
//	printSVector(carDir);
//	cout << endl << "car Time:" << endl;
//	printSVector(carTime);
	
	trafficLigh(carTime, carDir);
	
//	cout << "Direction ID # car arrived intersection (e.g., West #3 car arrived)" << endl;
//	cout << "Direction ID # car left intersection (e.g., West #3 car left intersection)" << endl;
	
	return 0;
}
//======================================main end======================================//
