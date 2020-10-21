#include <winsock2.h>
#include <ws2tcpip.h>
#include <iostream>
#include <string>
#define _WIN32_WINNT 0x501
using namespace std;

#pragma comment (lib, "Ws2_32.lib")

#define DEFAULT_BUFLEN 512            
#define IP_ADDRESS "192.168.56.1"
#define DEFAULT_PORT "3504"

WSADATA wsaData;
SOCKET ConnectSocket = INVALID_SOCKET;
struct addrinfo *result = NULL,
                *ptr = NULL,
                hints;
char recvbuf[DEFAULT_BUFLEN];
int iResult = 0;
int recvbuflen = DEFAULT_BUFLEN;
string msg = "";

int main()
{

    cout << "Starting Client...\n";

    iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
    if (iResult != 0) {
        cout << "WSAStartup failed with error: " << iResult << endl;
        return 1;
    }

    ZeroMemory( &hints, sizeof(hints) );
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;

    cout << "Connecting...\n";

    // Resolve the server address and port
    iResult = getaddrinfo(static_cast<LPCSTR>(IP_ADDRESS), DEFAULT_PORT, &hints, &result);
    if ( iResult != 0 ) {
        cout << "getaddrinfo failed with error: " << iResult << endl;
        WSACleanup();
        return 1;
    }

    // Attempt to connect to an address until one succeeds
    for(ptr=result; ptr != NULL ;ptr=ptr->ai_next) {

        // Create a SOCKET for connecting to server
        ConnectSocket = socket(ptr->ai_family, ptr->ai_socktype,
            ptr->ai_protocol);
        if (ConnectSocket == INVALID_SOCKET) {
            cout << "socket failed with error: " << WSAGetLastError() << endl;
            WSACleanup();
            return 1;
        }

        // Connect to server.
        iResult = connect( ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
        if (iResult == SOCKET_ERROR) {
            closesocket(ConnectSocket);
            ConnectSocket = INVALID_SOCKET;
            continue;
        }
        break;
    }

    freeaddrinfo(result);

    if (ConnectSocket == INVALID_SOCKET) {
        cout << "Unable to connect to server!\n";
        WSACleanup();
        return 1;
    }

    cout << "Successfully Connected\n\n";

    // Receive until the peer closes the connection
    do {
        cout << "Type in something:\n";
        msg = "";
        getline(cin,msg);
        //iResult = recv(ConnectSocket, recvbuf, recvbuflen, 0);
        iResult = send(ConnectSocket, msg.c_str(), strlen(msg.c_str()), 0);
        if ( iResult > 0 )
            cout << endl;
        else if ( iResult == 0 )
            cout << "Connection closed\n\n";
        else
            cout << "recv failed with error: " << WSAGetLastError() << endl;

    } while (iResult > 0);

    // shutdown the connection since no more data will be sent
    iResult = shutdown(ConnectSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        cout << "shutdown failed with error: " << WSAGetLastError() << endl;
        closesocket(ConnectSocket);
        WSACleanup();
        return 1;
    }
    // cleanup
    closesocket(ConnectSocket);
    WSACleanup();

    return 0;
}