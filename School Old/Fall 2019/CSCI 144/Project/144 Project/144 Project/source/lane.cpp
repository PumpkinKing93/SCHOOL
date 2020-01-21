//
//  lane.cpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include "lane.hpp"



void lane::going(){
	while (!cars.empty()) {
		thread thread_obj (cars.top());
//		unique_lock<mutex> mlock(mutex);
		cout<<"Passed car# = "<<cars.top().carID<<endl;
		cout<<"Passed Time = "<<cars.top().interval<<endl;
		cout << "Passed Dir " << cars.top().direction << endl;
//		ready.at(x) = false;
//		while (!ready.at(x))intersection.wait(mlock);
//			cout << "thread " << x << " completed!" << endl;
		cars.pop();
	}
};

void lane::wait(car carP){
	waiting.push_back(carP);
	cars.push(carP);
	
};
