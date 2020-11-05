//
//  simulation.cpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include "simulation.hpp"

void simulation::makeCars(){
	
	for(int i = 0; i<carDir.size(); i++){
		car *carP = new car(i, carTime[i], carDir[i]);

		light1.sortCar(*carP);
	}
	light1.light();
}

void simulation::readFile(int num){
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


void simulation::printDirVect(){
	for (auto i: carDir)
  cout << i << endl;
//	cout << i << ' ';
	return;
}

void simulation::printTimeVect(){
	
	for (auto i: carTime)
  cout << i << endl;
//	cout << i << ' ';
	return;
}



void simulation::start(){
	makeCars();
	light1.startLight();
	
//	for(int i=0; i<North.waiting.size()){
//	light1.light(North.waiting[]);
//	}
}
