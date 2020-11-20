#include <iostream>
#include <WS2tcpip.h>
#include <string>

//Only include once
#pragma comment (lib, "ws2_32.lib")

using namespace std;

void main(int argc, char *argv[])
{
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
	string s("Program Started");
	int send = sendto(out, s.c_str(), s.size() + 1, 0, (sockaddr*)&server, sizeof(server));

	char buf[1024];

	if (send == SOCKET_ERROR)
	{
		cout << "ERROR 2: no work" << WSAGetLastError() << endl;
	}

	// submit a random bid price + %5-%20 percent of the items total price.
	// Must be less than the total cost of the item
	// The server should compare the bid price and update if higher and post the highest bid price

	while (true)
	{
		//clear a spot in mem
		ZeroMemory(buf, 1024);

		// wait for message
		int bytesIn = recvfrom(out, buf, 1024, 0, (sockaddr*)&server, &serverLength);
		if (bytesIn == SOCKET_ERROR)
		{
			cout << "ERROR 3: Not Getting Data." << WSAGetLastError() << endl;
			continue;
		}
		char serverIp[256];

		//clear a spot in mem
		ZeroMemory(serverIp, 256);
		inet_ntop(AF_INET, &server.sin_addr, serverIp, 256);

		cout << "Message from " << serverIp << " : " << buf << endl;
	}

	// Close the socket
	closesocket(out);

	//close Winsock
	WSACleanup();
}