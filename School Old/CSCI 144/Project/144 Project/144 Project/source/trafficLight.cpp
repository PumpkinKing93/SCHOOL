//
//  trafficLight.cpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include "trafficLight.hpp"

void trafficLight::sortCar(car carP){
	cout << carP.direction << endl;
	if(carP.direction == "N"){
	  North.wait(carP);
		
	}
	if(carP.direction == "E"){
	  East.wait(carP);
	}
	if(carP.direction == "W"){
	  West.wait(carP);
	}
	if(carP.direction == "S"){
	  South.wait(carP);
	}
	
	if(carP.direction == "NE"){
	  North.wait(carP);
	}
	if(carP.direction == "NW"){
	  North.wait(carP);
	}
	
	if(carP.direction == "SE"){
	  South.wait(carP);
	}
	if(carP.direction == "SW"){
	  South.wait(carP);
	}
	
	if(carP.direction == "ES"){
	  East.wait(carP);
	}
	if(carP.direction == "EN"){
	  East.wait(carP);
	}
	
	if(carP.direction == "WS"){
	  West.wait(carP);
	}
	if(carP.direction == "WN"){
	  West.wait(carP);
	}
}

void trafficLight::light(){
	int safeToGo = 0;
//	cout << " reched the light." << endl;
	
	for(int i =0; i < North.waiting.size(); i++){
//		North.waiting[i];
//		cout << North.waiting[i].direction << " Car #" << North.waiting[i].carID << " Arrived" <<  endl;
//			cout << North.cars.top().direction << " Car #" << North.cars.top().carID << " Arrived" <<  endl;
//		North.waiting.erase(find(North.waiting.begin(),North.waiting.end(),i));
//		North.waiting.erase(North.waiting.begin());
//		North.waiting.shrink_to_fit();
//		North.waiting.pop_front();
		
	}

	for(int i =0; i < East.waiting.size(); i++){
//		East.waiting[i];
		cout << East.waiting[i].direction << " Car #" << East.waiting[i].carID << " Arrived" <<  endl;
//		East.waiting.erase(find(East.waiting.begin(),East.waiting.end(),i));
	}
	
	for(int i =0; i < West.waiting.size(); i++){
//		South.waiting[i];
		cout << West.waiting[i].direction << " Car #" << West.waiting[i].carID << " Arrived" <<  endl;
//			West.waiting.erase(find(West.waiting.begin(),West.waiting.end(),i));
	}
	
	for(int i =0; i < South.waiting.size(); i++){
//			West.waiting[i];
		cout << South.waiting[i].direction << " Car #" << South.waiting[i].carID << " Arrived" <<  endl;
//			South.waiting.erase(find(South.waiting.begin(),South.waiting.end(),i));
	}


}

void trafficLight::isSafe(vector<car> *vect){
	cout << "test: " << North.waiting[0].carID<< endl;
}

void trafficLight::startLight()
{
//priority_queue<class _Tp>
//	cout << "starting threads" << endl;
	North.going();
//	thread t1 (&lane::going, &North);
//	thread t2(&lane::going, &South);
//	thread t3(&lane::going, &West);
//	thread t4(&lane::going, &East);
//
//	cout << "ending threads" << endl;
//	t1.join();
//	t2.join();
//	t3.join();
//	t4.join();
	
}


