//
//  main.cpp
//  144 Project
//
//  Created by Tyler Gillette on 9/16/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include <iostream>
#include <thread>
int main()
{
//	int x = 9;
	std::thread threadObj([]{
		for(int i = 0; i < 10000; i++)
			std::cout<<"Display Thread Executing"<<std::endl;
	});
	
	for(int i = 0; i < 10000; i++)
		std::cout<<"Display From Main Thread"<<std::endl;
	
	threadObj.join();
	std::cout<<"Exiting from Main Thread"<<std::endl;
	return 0;
}
