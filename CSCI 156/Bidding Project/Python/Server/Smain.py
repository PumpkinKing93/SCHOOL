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

# host = '192.168.252.208'
host = '192.168.86.39'
port = 25000
items = []
curBid = []
origPrice = []

serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serv.bind((host, port))
serv.listen(5)

print('\n', "Waiting For Client", '\n')
s_items = ""
while True:
    conn, addr = serv.accept()
    # from_client = 'Client: '
    from_client = ' '

    while True:
        data = conn.recv(4096)

        if not data:
            break

        from_client = from_client + data.decode()

        # if (len(items) == 0) & (len(data) > 0) & (data.decode()[0] == '['):
        if (len(data) > 0) & (data.decode()[0] == '['):
            newData = data
            newData = json.loads(newData)
            items.extend(newData)
            # print("from_client: ", newData, '\n')

        
        print("from_client: ", from_client, '\n')

        if (len(items) == 0):
            s_items = json.dumps(item3)
            conn.send(s_items.encode())
            origPrice = item3

        if (len(items) > 0):
            for index in range(len(origPrice)):
                # for key in items[index]:
                # print("items: ", type(items[index]['Cost']))
                # print("items3: ", type(int(item3[index]['Cost'])))

                if (len(curBid) == 0):
                    curBid = []
                    curBid.extend(newData)

                if (origPrice[index]['Cost'] != items[index]['Cost']):
                    items = []
                    newData = data
                    newData = json.loads(newData)
                    items.extend(newData)
                    # print("LEN: ", len(origPrice), len(items), index )
                    # print("Original: ", origPrice)
                    # print("UPDATED ITEMS: ", items)
                    # print("Current Bid: ", curBid)
                    exit

                if (items[index]['Cost'] > curBid[index]['Cost']) & items[index]['Cost'] != -1:
                    curBid[index]['Cost'] = items[index]['Cost']
                    print("Current Bid1: ", curBid)
                    exit

                if (curBid[index]['Cost'] == -1):
                    print("Item is Sold:", curBid[index]['Cost'])
                    exit

                if (int(curBid[index]['Cost']) >= int(origPrice[index]['Cost'])):
                    # items.pop(items[index]['Cost'])
                    curBid[index]['Cost'] = -1
                    origPrice[index]['Cost'] = -1

                    exit

            SoldOut = all(value == -1 for value in curBid[index].values())

            if (not SoldOut):
                s_items = json.dumps(curBid)
                conn.send(s_items.encode())
            else:
                print("Sold out: ", SoldOut)
                conn.close()



            # print("list of items: ", s_items, '\n')

            # check if the bid received is equal or greater than price
            # need to send back current bid
            # mark item sold, remove from list
    conn.close()
    print('client disconnected', '\n')
