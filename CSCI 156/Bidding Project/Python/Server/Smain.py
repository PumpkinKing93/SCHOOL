import socket
import sys
import json
from items import *

# In this individual project, you will implement a bidding system (similar to eBay) in a
# networked environment involving at least two computers, or in a Linux/UNIX server.

# In your program, N clients periodically randomly pick up an item from a predefined list.
# For any client, if the item's bidding price is below the client's pre-set highest price,
# it then submits a request to the server for bidding. The bidding price should be the current
# bidding price plus a small random number between 5% to 20%. The server, upon receipt of a new
# bid, compares the bid price and current price.  If the bid price is higher, then the server
# updates the current price and broadcasts (multicasts) to all clients the change. This broadcast
# can be immediately and can also be delayed to T interval after the last broadcast to avoid too
# frequent broadcast messages.

# Eventually, all clients except one should see the current bid price is higher than its pre-set
# highest price to bid. The winner will be the one with the highest pre-set price for that item.

host = '192.168.252.208'
port = 25000

serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serv.bind((host, port))
serv.listen(5)

print('\n', "Waiting For Client", '\n')
s_items = ""
while True:
    conn, addr = serv.accept()
    from_client = 'Client: '

    while True:
        data = conn.recv(4096)

        if not data:
            break

        from_client = from_client + data.decode(sys.stdout.encoding)

        print(from_client)

        s_items = json.dumps(item3)
        conn.send(s_items.encode())

        # print("list of items: ", s_items, '\n')

    conn.close()
    print('client disconnected', '\n')
