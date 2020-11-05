
#include <iostream>

using namespace std;

int CashierNum = 0;

class Market { //market class to hold everything.
protected:
static int apples;
static int oranges;
static int bananas;
static int pineapples;
static int profits; // total profits
static int cashiers; //total number of cashiers wokring
static int transactions; //tot number of transactions

    void getApples(int &X){
        X = this->apples;
    }
    
    void getOranges(int &X){
        X = this->oranges;
    }
    
    void getBananas(int &X){
        X = this->bananas;
    }
    
    void getPineapples(int &X){
        X = this->pineapples;
    }
    
    void getProfits(int &X){
        X = this->profits;
    }
    
    void getCashiers(int &X) {
        X = this->cashiers;
    }
    
    void getTransactions(int &X) {
        X = this->transactions;
    }
    
    void updateApples(int X) {
        this->apples = this->apples - X;
    }
    
    void updateBananas(int X) {
        this->bananas = this->bananas - X;
    }
    void updateOranges(int X) {
        this->oranges = this->oranges - X;
    }
    void updatePineapples(int X) {
        this->pineapples = this->pineapples - X;
    }
    
    void updateProfits(int X) {
        this->profits = this->profits + X;
    }
    
    void updateCashiers(int X) {
        this->cashiers = this->cashiers + X;
    }
    
    void updateTransactions(int X) {
        this->transactions = this->transactions + X;
    }

public:

    
    void displayAll(){
        cout << "Apples " << this->apples << endl;
        cout << "Oranges " << this->oranges << endl;
        cout << "bananas " << this->bananas << endl;
        cout << "pineapples " << this->pineapples << endl;
        cout << "profits " << this->profits << endl;
        cout << "transactions " << this->transactions << endl;
    }
    
    Market(){};

};

//Initialize static attributes
//name of the calss :: attribute
int Market::apples = 100;
int Market::oranges = 130;
int Market::bananas = 218;
int Market::pineapples = 231;
int Market::cashiers = 0;
int Market::profits = 0;
int Market::transactions = 0;

class Cashier : public Market {
private:
    
    void getProfits(int &X){
        X = this->profitsl;
    }
    
    void getTransactions(int &X) {
        X = this->transactionsl;
    }
    
    void updateProfits(int X) {
        this->profitsl = this->profitsl + X;
    }
    
    void updateTransactions(int X) {
        this->transactionsl = this->transactionsl + X;
    }
    
protected:

    int profitsl;
    int transactionsl;
    int id;
    
public:
    Cashier() {
        profitsl = 0;
        transactionsl = 0;
        updateCashiers(1); //update the number of cashiers working at the Market
        id = CashierNum++;
    }
    
    
    void makePurchase(string Fruit, int Amount, bool &Completed) {
        int stored;
        Market::updateTransactions(1);
        updateTransactions(1);
        if (Fruit == "apple") {
            getApples(stored);
            if (stored > Amount) {
                updateApples(Amount); //Update Cashier apple count
                updateProfits(5*Amount); //Update Market Profits
                Market::updateProfits(5*Amount); //Update Cashier Profits
                Completed = true;
            }
            else {
                Completed = false;
            }
        }
        // Likewise for the other fruits
    }
    
    void displayAll() {
        cout << "Cashier " << id << endl;
        cout << "Profits " << profitsl << endl;
        cout << "Transactions " << transactionsl << endl;
        cout << "Market" << endl;
        Market::displayAll();
        int X;
        Market::getCashiers(X);
        cout << "Cashier Count " << X << endl;
    }

};

int main(int argc, const char * argv[]) {

    
    Cashier cash1, cash2, cash3;
    cash1.displayAll();
    bool Complete;
    cash1.makePurchase("apple", 2, Complete);
    cash2.makePurchase("apple", 1, Complete);
    cash3.makePurchase("apple", 3, Complete);
    cash1.displayAll();
    cash2.displayAll();
    cash3.displayAll();
    
    return 0;
}
