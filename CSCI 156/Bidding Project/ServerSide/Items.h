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
	string getDescription() { 
		return Desc; 
	};

	void setDescription(string description) { 
		Desc = description; 
	};

	int getUnits() {
		return Units; 
	};

	void setUnits(int units) { 
		Units = units; 
	};
	
	int getPrice() { 
		return Price; 
	};
	
	void setPrice(int price) { 
		Price = price; 
	};
};

