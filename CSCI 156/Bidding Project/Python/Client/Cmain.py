import socket
import json
import random
from clearList import *

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

print("Connecting to Server.", '\n')

host = '192.168.252.208'
port = 25000
items = []

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((host, port))

if len(items) == 0:
    client.send("What do you have to buy?".encode())
    from_server = client.recv(4096)

    data = from_server
    data = json.loads(data)
    items.extend(data)

    clearList(items)

    print("Items: ", items, '\n')
    client.close()


if len(items) > 0:
    # for k, v in items.items():
    #     if v is not None:
    #         items[k] = items[k] + random.randint(1, 1001)

    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((host, port))
    client.send("test back".encode())
    from_server = client.recv(4096)
    client.close()


# client.send("What do you have to buy?".encode())
# from_server = client.recv(4096)
# print("From Server: ", from_server, '\n')


client.close()

# print(from_server)
