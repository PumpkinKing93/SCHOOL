#pragma once
#include <string>

using namespace std;
class Items
{
private:
	string Desc;
	int Units;
	int Price;
public:
	//constructor & destructor
	Items(string desc, int units, int price) {
		Desc = desc;
		Units = units;
		Price = price;
	};
	~Items();

	//getter and setter to move data in and out
	void setDescription(string description) {
		Desc = description;
	};

	void setUnits(int units) {
		Units = units;
	};

	void setPrice(int price) {
		Price = price;
	};

	string getDescription() {
		return Desc;
	};

	int getUnits() {
		return Units;
	};

	int getPrice() {
		return Price;
	};

};

