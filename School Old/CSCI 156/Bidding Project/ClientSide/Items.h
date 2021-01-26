#pragma once
#include <string>

using namespace std;
class Items
{
private:
	string Desc;
	int Available;
	int Price;
public:
	//constructor & destructor
	Items(string desc, int available, int price) {
		Desc = desc;
		Available = available;
		Price = price;
	};
	~Items();

	//getter and setter to move data in and out
	void setDescription(string description) {
		Desc = description;
	};

	void setAvailable(int available) {
		Available = available;
	};

	void setPrice(int price) {
		Price = price;
	};

	string getDescription() {
		return Desc;
	};

	int getAvailable() {
		return Available;
	};

	int getPrice() {
		return Price;
	};

};

