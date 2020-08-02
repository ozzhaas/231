#include <stdio.h>
#include <math.h>

int main()
{
  int sign, exp, fraction, significand;
  int i;
  float f;
  float prev = 0;

  for (i = 0; i < 256; i++)
  {
    /* begin your code */
    sign = (i >> 7) & 1;    //asr the constant 7 by 1
    exp = (i >> 3) & 15;    //asr the constant 3 by 15

    fraction = i & 7;       //and i by 7 to get the fraction value

    int de_normal = 0;      //initialize denormal variable
    if (exp == 0) {         //check if the exponent is denormal
        de_normal = 1;      //if yes, set denormal and exponent to 1
        exp = 1;
    }

    exp = exp - 8;          //convert the exponent by subtracting 8

    if (de_normal == 0) {   //set the bits for the full significand
        significand = 8 | fraction;
    }
    else {
        significand = fraction;
    }

    exp = exp - 3;

    //calculate the float number
    f = significand * pow(2, exp);
    if (sign == 1) {
        f = f * 1;
    }

    /* end your code */

    printf ("%02x => %08x = %+11.6f (spacing = %+11.6f)\n",
            i, *(int*) &f, f, prev-f);
    prev = f;
  }

  return 0;
}
