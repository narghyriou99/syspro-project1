#include "help.h"

using namespace std;

int main(int argc, char* argv[]){


	if (argc < 5) {
		cout << "Arguments are missing!" << endl;
		return 0;
	}
	//Fix the args to the correct values
	int bloomSize = 0 , index = 1;
	string fileName;
	while (index < argc) {
		if (!strcmp(argv[index], "-c"))
			fileName = argv[index + 1];
		else if (!strcmp(argv[index], "-b"))
			bloomSize = atoi(argv[index + 1]);
		index += 2;
	}
	fileName = "./source/" + fileName;
	string word; 
	int totalRecords = 0;	//All records 
	int count = 1;
	fstream file;
	file.open(fileName);
	if (file.fail()) {
		cout << "Error opening file!" << endl;
		return -1;
	}
	int citizenId, age;
	string firstName, lastName, country, virusName, dateVaccinated, isVaccinated;
	string emptyString;
	emptyString.clear();
	List* virusList = new List();
	CitizenList* citizenList = new CitizenList();
	CountryList* countryList = new CountryList();
	VirusList* virusNameList = new VirusList();
	AgeList* ageList = new AgeList();
	while (file >> word){
		switch (count) {
		case 1:
			citizenId = stoi(word);
			break;
		case 2:
			firstName = word;
			totalRecords++;
			break;
		case 3:
			lastName = word;
			break;
		case 4:
			country = word;
			break;
		case 5:
			age = stoi(word);
			break;
		case 6:
			virusName = word;
			break;
		case 7:
			isVaccinated = word;
			break;
		case 8:
			dateVaccinated = word;
			break;
		}
		
		if (count == 8) {
			if (!isVaccinated.compare("YES") && dateVaccinated.length() > 4) {	//Yes with date
				Entry(citizenList, countryList, virusNameList, ageList, virusList, citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated, bloomSize);
				ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
				count = 0;
			}
			if (!isVaccinated.compare("YES") && dateVaccinated.length() <= 4) {	//Yes with no date
				cout << "ERROR IN RECORD " << citizenId << endl;
				ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
				citizenId = stoi(word);
				count = 1;
			}
			if (!isVaccinated.compare("NO") && dateVaccinated.length() > 4) {	// No with date
				cout << "ERROR IN RECORD " << citizenId << endl;
				ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
				count = 0;
			}
			if (!isVaccinated.compare("NO") && dateVaccinated.length() <= 4) {	// No with no date
				Entry(citizenList, countryList, virusNameList, ageList, virusList, citizenId, firstName, lastName, country, age, virusName, isVaccinated, emptyString, bloomSize);
				ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
				citizenId = stoi(word);
				count = 1;
			}
		}
		count++;
	}
	//Check last record
	if (!isVaccinated.compare("YES") && dateVaccinated.length() > 4) {	//Yes with date
		Entry(citizenList, countryList, virusNameList, ageList, virusList, citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated, bloomSize);
		ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
	}
	if (!isVaccinated.compare("YES") && dateVaccinated.length() <= 4) {	//Yes with no date
		cout << "ERROR IN RECORD " << citizenId << endl;
		ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
	}
	if (!isVaccinated.compare("NO") && dateVaccinated.length() > 4) {	// No with date
		cout << "ERROR IN RECORD " << citizenId << endl;
		ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
	}
	if (!isVaccinated.compare("NO") && dateVaccinated.length() <= 4) {	// No with no date
		Entry(citizenList, countryList, virusNameList, ageList, virusList, citizenId, firstName, lastName, country, age, virusName, isVaccinated, emptyString, bloomSize);
		ResetData(citizenId, firstName, lastName, country, age, virusName, isVaccinated, dateVaccinated);
	}


 	citizenList->printList();	//print cit list for debugging
	virusList->printList();	//print virus list for debugging

	getCommand(virusList, citizenList, countryList, virusNameList, ageList, bloomSize);

	//delete memory
	delete ageList;
	delete virusNameList;
	delete countryList;
	delete virusList;
	delete citizenList;
	file.close();
	return 0;
}