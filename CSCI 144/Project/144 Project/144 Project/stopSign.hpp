//
//  stopSign.hpp
//  144 Project
//
//  Created by Tyler Gillette on 10/25/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#ifndef stopSign_hpp
#define stopSign_hpp

#include <stdio.h>
#include <vector>
#include <iostream>
#include <queue>
#include <algorithm>

//Thread Utilities
#include <thread>
#include <future>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <mutex>
#include <condition_variable>

//Timing Utilities
#include <time.h>
#include <unistd.h>


class argument
{
public:
	int size;
	int direction;
	std::vector<double> contents;
	bool verbose;
	/*argument(int sz, double cont[]){
		size = sz;
		for (int i=0; i<size;i++)
			contents[i]=cont[i];
	};*/
};



#endif /* stopSign_hpp */

