/*
Kellen Haas
CPSC 2310 Sec. 001
Assignment 2
07/22/20
*/

/*This program will compute 8 bit by 8 bit binary multiplication
  and also show the steps involved. */

#include <iostream>
#include <stdio.h>
#include <string>
#include <vector>
#include <iomanip>
#include <sstream>
using namespace std;

/*Creates a struct of the variables and registers we need to access*/
struct vars {
    int input1, input2, multiplicand, multiplier, carry, acc, mq, mdr;
};


/*Converts an integer to its binary value for a specific bit length*/
string prt_bin(int value, int length) {
    int i;
    string binString;

    for (i = (length - 1); i >= 0; i--) {
        if ((value >> i) & 1) {
            binString.push_back('1');
        }
        else {
            binString.push_back('0');
        }
    }
    return binString;
}

/*Intializes the variables and prints out the very top section of the program*/
void initialize_vars(vars* initVars) {

    cout << endl << "\tmultiplicand: " << initVars->multiplicand << endl;
    cout << "\tmultiplier: " << initVars->multiplier << endl << endl << endl;

    initVars->acc = 0;
    initVars->carry = 0;
    cout << "\tc and acc set to 0\n";

    initVars->mq = initVars->multiplier;
    cout << "\tmq set to multiplier     = " << initVars->multiplier;
    cout << " decimal and ";
    cout << prt_bin(initVars->multiplier, 8) << " binary\n";

    initVars->mdr = initVars->multiplicand;
    cout << "\tmdr set to multiplicand  = " << initVars->multiplicand;
    cout << " decimal and ";
    cout << prt_bin(initVars->multiplicand, 8) << " binary\n\n";
    cout << "\t- - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n";

}

/*This function has the decision process for whether to add the two binary
  registers the ACC and MDR based on the binary converted input number's last
  digit. It also uses the carry variable in case two 1's are added together
  during addition.*/
void resultAddOrNoAdd(vars* aVars) {

    int lastDigit = prt_bin(aVars->mq, 8)[7];
    if (lastDigit == '1') {
        cout << "\t    +     " << prt_bin(aVars->mdr, 8);
        cout << "        ^ add based on lsb = 1\n";
        cout << "           - - - - - - - - - -\n";
        aVars->acc = aVars->acc + aVars->multiplicand;
        if (aVars->acc > 255) {
            aVars->carry = 1;
        }
    }
    else {
        cout << "\t    +     " << prt_bin(0, 8);
        cout << "        ^ no add based on lsb = 0\n";
        cout << "           - - - - - - - - - -\n";
    }
    cout << "\t\t" << aVars->carry << " " << prt_bin(aVars->acc, 8) << " ";
    cout << prt_bin(aVars->mq, 8) << endl;
}


/*This function controls the third part of each step involving the logical
  shift right of the binary number that resulted from adding the ACC and MDR.*/
void lsr(vars* lVars) {
    cout << "\t   >>\t\t\t     shift right\n";
    lVars->mq = lVars->mq >> 1;

    if (prt_bin(lVars->acc, 8)[7] == '1') {
        lVars->mq += 128;
    }

    lVars->acc = lVars->acc >> 1;
    lVars->carry = 0;

    cout << "\t\t" << lVars->carry << " " << prt_bin(lVars->acc, 8) << " ";
    cout << prt_bin(lVars->mq, 8) << endl;

    cout << "\t- - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n";
}


/*This function will be used to calculate the decimal version of the binary
  number result and use it to check the program.*/
int binToDec(int num) {
    int b = 1;
    int remain = 0;
    int temp = num;
    int decResult = 0;
    while (temp) {
        remain = temp % 10;
        temp = temp/10;
        decResult += remain * b;
        b = b * 2;
    }
    return decResult;
}



/*This function will check the binary result to make sure it matches the output
  that we receive from simply multiplying the two input numbers.*/
void checkBinaryResult(vars* cVars) {
    stringstream string;
    string << "check:\t\t\t  binary      decimal\n";
    string << "\t\t\t" << right << setw(7) << setfill(' ');
    string << prt_bin(cVars->multiplicand, 8) << "\t" << right << setw(5);
    string << setfill(' ') << cVars->multiplicand << endl;
    string << "\t\tx\t" << right << setw(7) << setfill(' ');
    string << prt_bin(cVars->multiplier, 8) << "      x" << right << setw(6);
    string << setfill(' ') << cVars->multiplier << endl;

    string << "\t\t- - - - - - - - -    - - - - -\n";

    string << " \t\t" << right << setw(5) << setfill(' ');
    string << prt_bin(cVars->acc, 8) << prt_bin(cVars->mq, 8) << "    ";
    string << right << setw(9) << setfill(' ') << cVars->input1 * cVars->input2;
    string << endl;

    cout << string.str();
}



int main () {
    struct vars mVars;

    cout << "Enter two numbers to multiply them (i.e. 7 12): \n";
    cin >> mVars.input1 >> mVars.input2;

    if ((mVars.input1 < 0) || (mVars.input2 < 0)) {
        cout << "\tError: Number must be greater than or equal to 0.\n";
        return(0);
    }
    else if ((mVars.input1 > 255) || (mVars.input2 > 255)) {
        cout << "\tError: Number must be less than or equal to 255.\n";
        return(0);
    }
    else {
        mVars.multiplicand = mVars.input1;
        mVars.multiplier = mVars.input2;
        initialize_vars(&mVars);

        for (int j = 1; j <= 8; j++) {
            cout << "step " << j << ": \t" << mVars.carry << " ";
            cout << prt_bin(mVars.acc, 8);
            cout << " " << prt_bin(mVars.mq, 8) << endl;
            resultAddOrNoAdd(&mVars);
            lsr(&mVars);
        }
        checkBinaryResult(&mVars);
        cout << endl << endl;
    }

	return 0;
}
