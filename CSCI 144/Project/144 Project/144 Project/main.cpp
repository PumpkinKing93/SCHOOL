//
//  main.cpp
//  144 Project
//
//  Created by Tyler Gillette on 9/16/19.
//  Copyright © 2019 Tyler  Gillette. All rights reserved.
//

#include <iostream>
#include <thread>
using namespace std;

//classes

//functions

int main()
{
	//declare variables

	//function calls
	//	int x = 9;
	thread threadObj([] {
		for (int i = 0; i < 10000; i++)
			cout << "Display Thread Executing" << endl;
	});

	for (int i = 0; i < 10000; i++)
		cout << "Display From Main Thread" << endl;

	threadObj.join();
	cout << "Exiting from Main Thread" << endl;

	return 0;
}
