// ClientSide.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <WS2tcpip.h>
#include <string>


#pragma comment (lib, "ws2_32.lib")

using namespace std;

void main(int argc, char* argv[])
{
	//pulled from MS tutorial
	WSADATA data;
	WORD version = MAKEWORD(2, 2);
	int wsError = WSAStartup(version, &data);
	if (wsError != 0)
	{
		cout << "Winsock Error..." << wsError << endl;
	}

	// Create a hint structure for the server
	sockaddr_in server;
	int serverLength = sizeof(server);

	//clear a block of memory (dest, len)
	ZeroMemory(&server, serverLength);

	server.sin_family = AF_INET;
	server.sin_port = htons(25001);
	inet_pton(AF_INET, "127.0.0.1", &server.sin_addr);

	// Socket Creation
	SOCKET out = socket(AF_INET, SOCK_DGRAM, 0);

	// Write to the socket
	string s(argv[1]);
	int sentData = sendto(out, s.c_str(), s.size() + 1, 0, (sockaddr*)&server, sizeof(server));


	//pulled from MS tutorial

	if (sentData == SOCKET_ERROR)
	{
		cout << "Why do you no work?!?!?" << WSAGetLastError() << endl;
	}

	char buf[1024];
	while (true)
	{
		//clear a block of memory (dest, len)
		ZeroMemory(buf, 1024);

		int bytesIn = recvfrom(out, buf, 1024, 0, (sockaddr*)&server, &serverLength);
		if (bytesIn == SOCKET_ERROR)
		{
			cout << "Error when getting data from client" << WSAGetLastError() << endl;
			continue;
		}
		char serverIp[256];

		//clear a block of memory (dest, len)
		ZeroMemory(serverIp, 256);
		inet_ntop(AF_INET, &server.sin_addr, serverIp, 256);

		cout << "Message received from " << serverIp << " : " << buf << endl;
	}

	// Close the socket
	closesocket(out);

	//close Winsock
	WSACleanup();
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
