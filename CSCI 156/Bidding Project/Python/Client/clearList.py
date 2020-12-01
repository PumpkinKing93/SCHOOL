def clearList(items):
    for index in range(len(items)):
        for key in items[index]:
            items[index][key] = 0
