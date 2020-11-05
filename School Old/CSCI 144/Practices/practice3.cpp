#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
using namespace std;

const int MAX = 10;

class TSQueue{
	mutex lock;

	int items[MAX];
	int front;
	int nextEmpty;

	public:
		TSQueue();
		~TSQueue(){};
		bool tryInsert(int item);
		bool tryRemove(int* item);
};

TSQueue::TSQueue(){
	front = nextEmpty = 0;
}

bool TSQueue::tryInsert(int item){
	bool success = false;
	
	lock.lock();
	if((nextEmpty-front) < MAX){
		items[nextEmpty % MAX] = item;
		nextEmpty++;
		success = true;
	}
	lock.unlock();
	return success;
}

bool TSQueue::tryRemove(int* item){
	bool success = false;

	lock.lock();
	if(front < nextEmpty){
		*item = items[front % MAX];
		front++;
		success = true;
	}
	lock.unlock();
	return success;
}

void *putSome(void *p){
	TSQueue *queue = (TSQueue *)p;
	int i;

	for(i=0;i<50;++i){
		queue->tryInsert(i);
	}
	return NULL;
}

void testRemoval(TSQueue *queue){
	int i, item;

	for(i=0;i<20;i++){
		if(queue->tryRemove(&item))
			cout << "Removed " << item << endl;
		else
			cout << "Nothing there." << endl;
	}
}

int main(){
	TSQueue *queues[3];
	thread workers[3];
	int i,j;

	for(i=0;i<3;++i){
		queues[i]=new TSQueue();
		workers[i]=(thread(&putSome, queues[i]));
	}

	//workers[0].join();
	for(i=0;i<3;++i){
 		workers[i].join();
	}

	for(i=0;i<3;++i){
		cout << "Queue " << i << endl;
		testRemoval(queues[i]);
	}

	return 0;
}