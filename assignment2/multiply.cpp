/*
Kellen Haas
CPSC 2310
Assignment 2
07/21/20
*/


#include <iostream>
using namespace std;

int main () {
    int input1;
    int input2;

    cout << "Enter two numbers to multiply them (i.e. 1, 2): \n";
    cin >> input1 >> input2;

    if ((input1 < 0) || (input2 < 0)) {
        cout << "Error: Number must be greater than or equal to 0.\n";
        exit(0);
    }
    else if ((input1 > 255) || (input2 > 255)) {
        cout << "Error: Number must be less than or equal to 255.\n";
        exit(0);
    }
    else {

    }


    cout << "\tmultiplicand: " <<
    cout << "\tmultiplier: " <<

	return 0;
}


void prt_bin(int value, int length) {
    int i;

    for (int i = (length - 1); i >= 0; i--) {
        if ((value >> i) & 1) {
            putchar('1');
        }
        else {
            putchar('0');
        }
}
