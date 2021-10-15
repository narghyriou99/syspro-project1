#ifndef HELP_H_
#define HELP_H_

#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <iomanip>
#include "citizen.h"
#include "virus.h"
#include "skiplist.h"
#include "bloomfilter.h"

using namespace std;



/*---------------Main----------------*/
void showOptions();
void getCommand(List* virusList, CitizenList* citList, CountryList* countryList, VirusList *virusNameList, AgeList *ageList, int BloomSize);
int checkForErrors(int mode, CountryList* countryList, List* virusList, CitizenList* citList, int citizenId, const string& virusName, const string& country);//0 is ok, -1 tis poutanas
string todayDate();

/*-------------Functions-------------*/

void ResetData(int& citizenId, string& firstName, string& lastName, string& country, int& age, string& virusName, string& isVactinated, string& dateVaccinated);
void Entry(CitizenList *citList, CountryList *countryList, VirusList* virusNameList, AgeList *ageList, List  *virusList, int citizenId, const string& firstName, const string& lastName, const string& country, int age, const string& virusName, const string& isVactinated, const string& dateVaccinated, int bfsize);
int checkIfDateisBetween(const string& date1, const string& date2, const string& date3);

/*--------------Queries--------------*/
void vaccineStatusBloom(List* virusList, int citizenId, const string& virusName);	//1st
void vaccineStatus(List* virusList, CN* citizen, const string& virusName);	//2nd 
void vaccineStatusAll(List* virusList, CitizenList* citList, int citizenId); //3rd
void populationStatus(int mode, CountryList* countryList, CitizenList* citList, node* virus, const string& country, const string& date1, const string& date2); //4th
void popStatusByAge(int mode, CitizenList* citList, CountryList* countryList, node* virus, const string& country, const string& date1, const string& date2); //5th
void insertCitizen(CitizenList* citList, CountryList* countryList, VirusList* virusNameList, AgeList* ageList, List* virusList, int citizenId, const string& firstName, const string& lastName, const string& country, int age, const string& virusName, const string& isVactinated, const string& dateVaccinated, int bfsize); //6th
void listNonVaccinatedPersons(node* virus);	//8th

#endif