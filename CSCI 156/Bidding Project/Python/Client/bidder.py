import random


def bidder(items):
    for index in range(len(items)):
        for key in items[index]:
            if (items[index][key] == 0):
                items[index][key] = random.randint(1, 5)
            else:
                items[index][key] = items[index][key] * \
                    random.uniform(1.05, 1.20)
