// ServerSide.cpp : This file contains the 'main' function. Program execution begins and ends there.

#include <iostream>
#include <WS2tcpip.h>
#include <string>
#include <cstdlib>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>

#include "Items.h"

#pragma comment (lib, "ws2_32.lib")

using namespace std;

vector<Items> loadStoreData()
{
	vector<Items> itemList;
	ifstream file("Inputs.txt");
	if (file.is_open())
	{
		//single line from the inputs
		string line;
		//each word from the lines
		string word;
		//sub string of the line
		string subLine;    
		//array of the columns from the inputs file
		string theItems[3];
		//just the items descriptions from the input file
		string itemDesc;
		//initialize the item info
		int itemUnits;
		int itemPrice;

		while (getline(file, line)) {
			subLine = line.substr(0, 4);
			if (subLine == "Items") {    //if the word is Item_
				int itemIndex = 0;
				istringstream iss(line);
				while (iss >> word) {
					theItems[itemIndex] = word;
					itemIndex++;
				}
				itemDesc = theItems[0];
				itemUnits = atoi(theItems[1].c_str());
				itemPrice = atoi(theItems[2].c_str());
				Items newItem = Items(itemDesc, itemUnits, itemPrice);
				itemList.push_back(newItem);
			}
		}

		cout << "The Store is Open for Business." << endl;
		cout << endl << "Please Connect a Clients to Start Transactions." << endl;

		file.close();
		return itemList;
	}
	else
	{
		cout << "Unable to open file";
		exit;
	}
}

void main()
{

	//pulled from MS tutorial
	WSADATA data;
	WORD version = MAKEWORD(2, 2);
	int wsError = WSAStartup(version, &data);

	if (wsError != 0)
	{
		cout << "Winsock Error..." << wsError << endl;
	}

	//bind socket to ip address and port
	SOCKET in = socket(AF_INET, SOCK_DGRAM, 0);

	sockaddr_in socketAddr;
	socketAddr.sin_addr.S_un.S_addr = ADDR_ANY;
	socketAddr.sin_family = AF_INET;
	socketAddr.sin_port = htons(25001); // convert from little to big endian

	if (bind(in, (sockaddr*)&socketAddr, sizeof(socketAddr)) == SOCKET_ERROR)
	{
		cout << "Can't bind socket!" << WSAGetLastError() << endl;
		return;
	}

	sockaddr_in client;
	int clientLength = sizeof(client);

	//clear a block of memory (dest, len)
	ZeroMemory(&client, clientLength);

	char buf[1024];

	SOCKET out = socket(AF_INET, SOCK_DGRAM, 0);
	//pulled from MS tutorial

	//send the items
	//create a vector to hold the item data
	vector<Items> items = loadStoreData();
	vector<string> s;

	//loop through and add the desc, unit and price of each of the input file items
	for (int i = 0; i < items.size(); i++)
	{
		s.push_back(items[i].getDescription() + " " + to_string(items[i].getUnits()) + " " + to_string(items[i].getPrice()));
	}

	
	while (true)
	{
		//clear a block of memory (dest, len)
		ZeroMemory(buf, 1024);


		int bytesIn = recvfrom(in, buf, 1024, 0, (sockaddr*)&client, &clientLength);

		//check that the return data doesnt contain an error
		if (bytesIn == SOCKET_ERROR)
		{
			cout << "Error when getting data from client" << WSAGetLastError() << endl;
			continue;
		}
		//if it didnt contain an error, send each piece of data
		else
		{
			for (int i = 0; i < items.size(); i++)
			{
				int sentData = sendto(out, s[i].c_str(), s[i].size() + 1, 0, (sockaddr*)&client, sizeof(client));
				if (sentData == SOCKET_ERROR)
				{
					cout << "Why do you no work?!?!?" << WSAGetLastError() << endl;
				}
			}
		}
		char clientIp[256];

		//clear a block of memory (dest, len)
		ZeroMemory(clientIp, 256);

		inet_ntop(AF_INET, &client.sin_addr, clientIp, 256);

		cout << "Message received from " << clientIp << " : " << buf << endl;
	}

	//close socket
	closesocket(in);

	//shutdown winsock
	WSACleanup();
}


// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Items to create new code files, or Project > Add Existing Items to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
