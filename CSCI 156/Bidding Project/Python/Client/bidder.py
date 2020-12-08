import random
import math


def bidder(items):
    for index in range(len(items)):
        if (items[index]['Cost'] == 0):
            items[index]['Cost'] = random.randint(1, 5)
        else:
            if (items[index]['Cost'] >= 1000):
                exit
            else:    
                items[index]['Cost'] = items[index]['Cost'] + (math.ceil(items[index]['Cost'] * random.uniform(1.05, 1.20)))
    return items