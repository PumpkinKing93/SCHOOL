//
//  lane.cpp
//  144 Project
//
//  Created by Tyler Gillette on 11/11/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include "lane.hpp"

void lane::going(){
	if (!cars.empty()) {
//		cout << ' ' << cars.top();
		cars.pop();
	}
};

void lane::wait(car carP){
	waiting.push_back(carP);
	cars.push(carP);
};
