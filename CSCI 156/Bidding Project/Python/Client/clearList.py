def clearList(items):
    for index in range(len(items)):
        for key in items[index]:
            items[index]['Cost'] = 0
            print("Clear: ", items[index][key])
