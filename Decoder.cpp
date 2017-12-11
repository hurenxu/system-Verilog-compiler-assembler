#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <bitset>
using namespace std;

#define MOVE 	0
#define ADDI 	1
#define ADDR 	2
#define SUBR 	3
#define SL 		4
#define SLR 	5
#define SNE 	6
#define SEQ 	7
#define SLT 	8
#define BEO 	9
#define BEZ 	10
#define LOAD	11
#define STORE	12
#define JUMP 	13
#define HALT 	14
#define OR	15
#define NIL		16

char convertFunction(string s) {
	char result = NIL;
	if (s == "Move")
		result = MOVE;
	else if (s == "Addi")
		result = ADDI;
	else if (s == "Addr")
		result = ADDR;
	else if (s == "Subr")
		result = SUBR;
	else if (s == "Sl")
		result = SL;
	else if (s == "Slr")
		result = SLR;
	else if (s == "Sne")
		result = SNE;
	else if (s == "Seq")
		result = SEQ;
	else if (s == "Slt")
		result = SLT;
	else if (s == "Beo")
		result = BEO;
	else if (s == "Bez")
		result = BEZ;
	else if (s == "Load")
		result = LOAD;
	else if (s == "Store")
		result = STORE;
	else if (s == "Jump")
		result = JUMP;
	else if (s == "Halt")
		result = HALT;
	else if (s == "Or")
		result = OR;
	return result;
}

int main(int argc, char** argv) {
	// read in arguments
	string in = argv[1];
	string out = argv[2];

	// open the input/output file
	ifstream inFile(in);
	ofstream outFile(out);
	string str;

	while (getline(inFile, str)) {
		// split the string by spaces
		cout << str << endl;
		vector<string> compo;
		std::istringstream iss(str);
		for (string token; iss >> token; ) {
			compo.push_back(token);
		}
		// check for empty line
		if (compo.size() == 0) {
			continue;
		}
		// check for comment
		else if (compo[0] == "#") {
			continue;
		}
		else if (compo[1] == ":") {
			continue;
		}
		else {
			char function = convertFunction(compo[0]);
			switch (function)
			{
			case MOVE:
			{
				bitset<5> imm(stoi(compo[1]));
				outFile << "0000" << imm << endl;
				break;
			}
			case ADDI:
			{
				bitset<5> imm(stoi(compo[1]));
				outFile << "0001" << imm << endl;
				break;
			}
			case ADDR:
			{
				if (compo[2] == "$acc") {
					outFile << "0010" << compo[1] << "10000" << endl;
				}
				else if (compo[2] == "$cout") {
					outFile << "0010" << compo[1] << "1111" << endl;
				}
				else if (compo[2].size() == 3) {
					bitset<4> reg(stoi(string(1, compo[2][2])));
					outFile << "0010" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][2]) + string(1, compo[2][3])));
					outFile << "0010" << compo[1] << reg << endl;
				}
				break;
			}
			case SUBR:
			{
				if (compo[2].size() == 3) {
					bitset<4> reg(stoi(string(1, compo[2][2])));
					outFile << "0011" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][2]) + string(1, compo[2][3])));
					outFile << "0011" << compo[1] << reg << endl;
				}
				break;
			}
			case SL:
			{
				if (compo[2].size() == 1) {
					bitset<4> reg(stoi(string(1, compo[2][0])));
					outFile << "0100" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][0]) + string(1, compo[2][1])));
					outFile << "0100" << compo[1] << reg << endl;
				}
				break;
			}
			case SLR:
			{
				if (compo[2] == "$acc") {
					outFile << "0101" << compo[1] << "10000" << endl;
				}
				else if (compo[2] == "$cout") {
					outFile << "0101" << compo[1] << "1111" << endl;
				}
				else if (compo[2].size() == 3) {
					bitset<4> reg(stoi(string(1, compo[2][2])));
					outFile << "0101" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][2]) + string(1, compo[2][3])));
					outFile << "0101" << compo[1] << reg << endl;
				}
				break;
			}
			case SNE:
			{
				if (compo[1].size() == 3) {
					bitset<5> reg(stoi(string(1, compo[1][2])));
					outFile << "0110" << reg << endl;
				}
				else {
					bitset<5> reg(stoi(string(1, compo[1][2]) + string(1, compo[1][3])));
					outFile << "0110" << reg << endl;
				}
				break;
			}
			case SEQ:
			{
				if (compo[1].size() == 3) {
					bitset<5> reg(stoi(string(1, compo[1][2])));
					outFile << "0111" << reg << endl;
				}
				else {
					bitset<5> reg(stoi(string(1, compo[1][2]) + string(1, compo[1][3])));
					outFile << "0111" << reg << endl;
				}
				break;
			}
			case SLT:
			{
				if (compo[1].size() == 3) {
					bitset<5> reg(stoi(string(1, compo[1][2])));
					outFile << "1000" << reg << endl;
				}
				else {
					bitset<5> reg(stoi(string(1, compo[1][2]) + string(1, compo[1][3])));
					outFile << "1000" << reg << endl;
				}
				break;
			}
			case BEO:
			{
				bitset<5> imm_offset(stoi(compo[1]));
				outFile << "1001" << imm_offset << endl;
				break;
			}
			case BEZ:
			{
				bitset<5> imm_offset(stoi(compo[1]));
				outFile << "1010" << imm_offset << endl;
				break;
			}

			case LOAD:
			{
				if (compo[2] == "$acc") {
					outFile << "1011" << compo[1] << "10000" << endl;
				}
				else if (compo[2] == "$cout") {
					outFile << "1011" << compo[1] << "1111" << endl;
				}
				else if (compo[2].size() == 3) {
					bitset<4> reg(stoi(string(1, compo[2][2])));
					outFile << "1011" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][2]) + string(1, compo[2][3])));
					outFile << "1011" << compo[1] << reg << endl;
				}
				break;
			}
			case STORE:
			{
				if (compo[2] == "$acc") {
					outFile << "1100" << compo[1] << "10000" << endl;
				}
				else if (compo[2] == "$cout") {
					outFile << "1100" << compo[1] << "1111" << endl;
				}
				else if (compo[2].size() == 3) {
					bitset<4> reg(stoi(string(1, compo[2][2])));
					outFile << "1100" << compo[1] << reg << endl;
				}
				else {
					bitset<4> reg(stoi(string(1, compo[2][2]) + string(1, compo[2][3])));
					outFile << "1100" << compo[1] << reg << endl;
				}
				break;
			}
			case JUMP:
			{
				bitset<5> imm_offset(stoi(compo[1]));
				outFile << "1101" << imm_offset << endl;
				break;
			}
			case HALT:
			{
				outFile << "111000000" << endl;
				break;
			}
			case OR:
			{
				if (compo[1].size() == 3) {
					bitset<5> reg(stoi(string(1, compo[1][2])));
					outFile << "1111" << reg << endl;
				}
				else {
					bitset<5> reg(stoi(string(1, compo[1][2]) + string(1, compo[1][3])));
					outFile << "1111" << reg << endl;
				}
				break;
			}
			}
		}
	}
	inFile.close();
	outFile.close();
	return 0;
}
