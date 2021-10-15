MODULE = ./source
INCLUDE = ./include

OBJS	= main.o help.o hash.o virus.o citizen.o skiplist.o bloomfilter.o
SOURCE	= main.cpp help.cpp hash.cpp virus.cpp citizen.cpp skiplist.cpp bloomfilter.cpp
HEADER	= help.h hash.h virus.h citizen.h skiplist.h bloomfilter.h
OUT	= vaccineMonitor
CC	 = g++
FLAGS	 = -g -c -Wall -I$(INCLUDE)
LFLAGS	 = 

all: $(OBJS)
	$(CC) -g $(OBJS) -o $(OUT) $(LFLAGS)

main.o: $(MODULE)/main.cpp
	$(CC) $(FLAGS) $(MODULE)/main.cpp -std=c++11

help.o: $(MODULE)/help.cpp
	$(CC) $(FLAGS) $(MODULE)/help.cpp -std=c++11

hash.o: $(MODULE)/hash.cpp
	$(CC) $(FLAGS) $(MODULE)/hash.cpp -std=c++11

virus.o: $(MODULE)/virus.cpp
	$(CC) $(FLAGS) $(MODULE)/virus.cpp -std=c++11

citizen.o: $(MODULE)/citizen.cpp
	$(CC) $(FLAGS) $(MODULE)/citizen.cpp -std=c++11

skiplist.o: $(MODULE)/skiplist.cpp
	$(CC) $(FLAGS) $(MODULE)/skiplist.cpp -std=c++11

bloomfilter.o: $(MODULE)/bloomfilter.cpp
	$(CC) $(FLAGS) $(MODULE)/bloomfilter.cpp -std=c++11


clean:
	rm -f $(OBJS) $(OUT)

run: $(OUT)
	./$(OUT) -c input.txt -b 100000

valgrind: $(OUT)
	valgrind ./$(OUT) -c input.txt -b 100000 

count:
	wc ./source/main.cpp ./source/help.cpp ./source/hash.cpp ./source/virus.cpp ./source/citizen.cpp ./source/skiplist.cpp ./source/bloomfilter.cpp ./include/help.h ./include/hash.h ./include/virus.h ./include/citizen.h ./include/skiplist.h ./include/bloomfilter.h
