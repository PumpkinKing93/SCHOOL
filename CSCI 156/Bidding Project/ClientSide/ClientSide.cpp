#include <iostream>
#include <WS2tcpip.h>
#include <string>
#include <vector>

#include "Items.h"

//Only include once
#pragma comment (lib, "ws2_32.lib")

using namespace std;

vector<Items> BiddingAgent(string buf) {
	// submit a random bid price + %5-%20 percent of the items total price.
	// Must be less than the total cost of the item
	// The server should compare the bid price and update if higher and post the highest bid price

	//create a vector to hold the incoming list of items, availbe and current bid
	vector<Items> availableItemList;

	//array of the columns from the inputs file
	string theItems[2];
	//init
	string itemDesc;
	int itemUnits;
	int itemPrice = 0;
	string temp;

	string s1 = buf;
	string s2 = buf;
	int slen = s1.length();
	string deliminator = ", ";
	itemDesc = s1.substr(0, s1.find(deliminator));
	itemUnits = atoi(s2.substr(s2.find(deliminator) + 1, slen).c_str());
	itemPrice = itemPrice + (rand() % 100);

	//cout << "buf" << buf << endl;
	//cout << "itemDesc: " << itemDesc << endl;
	//cout << "itemUnits: " << itemUnits << endl;
	//cout << "itemPrice: " << itemPrice << endl;
	//cout << endl;

	Items newItem = Items(itemDesc, itemUnits, itemPrice);
	availableItemList.push_back(newItem);

	return availableItemList;
}

void PrintItems(vector<Items> availableItemList) {

	for (int i = 0; i < availableItemList.size(); i++)
	{
		cout << "Item: " << endl;
		cout << "  Item Desc: " << availableItemList[i].getDescription() << endl;
		cout << "  Item Available:" << availableItemList[i].getAvailable() << endl;
		cout << "  Item Bid Price:" << availableItemList[i].getPrice() << endl << endl;
	}

	return;
}


void main(int argc, char *argv[])
{
	vector<Items> availableItemList;
	// start winsock
	WSADATA data;
	WORD version = MAKEWORD(2, 2);
	int wsStart = WSAStartup(version, &data);
	if (wsStart != 0)
	{
		cout << "ERROR 1: Can't start." << wsStart << endl;
	}

	// hint for the server
	sockaddr_in server;
	int serverLength = sizeof(server);
	
	//clear a spot in mem
	ZeroMemory(&server, serverLength);
	server.sin_family = AF_INET;
	server.sin_port = htons(25001);
	inet_pton(AF_INET, "127.0.0.1", &server.sin_addr);

	// Socket Creation
	SOCKET out = socket(AF_INET, SOCK_DGRAM, 0);

	// Write out to the socket
	string s("Customer Online");
	int send = sendto(out, s.c_str(), s.size() + 1, 0, (sockaddr*)&server, sizeof(server));

	char buf[1024];

	if (send == SOCKET_ERROR)
	{
		cout << "ERROR 2: no work" << WSAGetLastError() << endl;
	}

	// submit a random bid price + %5-%20 percent of the items total price.
	// Must be less than the total cost of the item
	// The server should compare the bid price and update if higher and post the highest bid price
	int i = 0;
	vector<string> sv;

	while (true)
	{
		
		//clear a spot in mem
		ZeroMemory(buf, 1024);

		// wait for message
		int bytesIn = recvfrom(out, buf, 1024, 0, (sockaddr*)&server, &serverLength);

		//check that the return data doesnt contain an error
		if (bytesIn == SOCKET_ERROR)
		{
			cout << "ERROR 3: Couldnt Connect to Server." << WSAGetLastError() << endl;
			continue;
		}

		char serverIp[256];

		//clear a spot in mem
		ZeroMemory(serverIp, 256);
		inet_ntop(AF_INET, &server.sin_addr, serverIp, 256);

		//cout << "Message from " << serverIp << " : " << buf << endl;

		availableItemList = BiddingAgent(buf);
		PrintItems(availableItemList);


		//client will submit the bid info to the server.
		//HOW DO I GET THIS INFO TO THE SERVER????
		if (availableItemList[i].getAvailable() > 0 && availableItemList.size() > i) {
			cout << "Loop " << i << endl;

			sv.push_back(availableItemList[i].getDescription() + ", " + to_string(availableItemList[i].getAvailable()) + ", " + to_string(availableItemList[i].getPrice()));
			cout << "SV: " << sv[i] << endl;

			int sentData = sendto(out, sv[i].c_str(), sv[i].size() + 1, 0, (sockaddr*)&server, sizeof(server));

			if (sentData == SOCKET_ERROR)
			{
				cout << "Why do you no work?!?!?" << WSAGetLastError() << endl;
			}
			//i++;
		}
		//i++;
	}



	// Close the socket
	closesocket(out);

	//close Winsock
	WSACleanup();
}