#include<iostream>
#include<string>
#include<sstream>
#include<fstream>
#include<map>
#include <unistd.h>
#include <fcntl.h>

using namespace std;

map<string,string> construct_map(string file){
	map<string,string> mymap;
	ifstream infile (file);
	int fd;
	string s, key, value;
	while(getline(infile,s)){
		istringstream ss(s);
		ss >> key >> value;
		mymap[key] = value;
	}
	close(fd);
	return mymap;
}

int main(int argc, char *argv[]){
	map<string,string> mymap = construct_map(argv[1]);
    string s;
	ifstream infile (argv[2]);
	getline(infile,s);
    cout << s << "\n";
	getline(infile,s);
    cout << s << "\n";
	while(getline(infile,s)){
		istringstream ss(s);
		string i1, i2, i3, i4, i5;
        ss >> i1 >> i2 >> i3 >> i4 >> i5;
        cout << i1 << "  "  << i2 << "  "  << i3 << "  "  << i4 << "  " << mymap[i5] << "  ";
		string tmp;
    	while(ss >> tmp){cout << tmp << "  ";}
		cout << "\n";
	}
}


