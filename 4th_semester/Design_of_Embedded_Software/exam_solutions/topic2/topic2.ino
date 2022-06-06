#include <enhanced_ino.hpp>

//low precision floating pt type
typedef struct myfloat
{
        signed char mantissa;
        signed char exponent;
} myfloat_type;


//convert from double to low precision type
void doub2mydouble(double arg, myfloat_type *res)
{
   int exponent;
   double temp;
   exponent = ceil(log(abs(arg))/log(2)); //base 2 logarithm
   temp=arg*pow(2,7-exponent);
   res->mantissa = (signed char)temp;
   res->exponent = exponent-7;
}

//convert from low precision type to double
double myfloat2double(myfloat_type *arg1)
{
  double res = (double)(arg1->mantissa) * pow(2,arg1->exponent);
   return res;
}

//multiply to low precision types
void mult_float(myfloat_type *arg1,myfloat_type *arg2,myfloat_type *result)
{
  int temp;
  unsigned char sign;
  
  sign=0x80 & ((unsigned char)arg1-> mantissa ^ (unsigned char)arg2-> mantissa); //find sign of result 
  
  char i=0;
   temp = (int)(arg1-> mantissa) * (int)(arg2-> mantissa);
   
   temp = temp & 0x7f00; //take away sign from product
  
   while(abs(temp)>128)
   {
      i++;
      temp=temp>>1;
   }
   
   result->mantissa = (unsigned char) temp;
   
   result->mantissa = result->mantissa | sign; //add recorded sign
   
   result->exponent = arg1->exponent + arg2->exponent + i;
   
}


#define arrsize 100
double a = 1.001;

double* randarray(){
    double* arr = (double*) malloc(arrsize);
    for(int i = 0; i < arrsize; i++){
        arr[i] = random(-5, 5);
    }
    return arr;
}

main(){
    Serial.begin(115200);
    double* da = randarray();
    myfloat_type mda[arrsize];

    for(int i = 0; i < arrsize; i++){ //convert to myfloat
        doub2mydouble(da[i], &mda[i]);
    }
    float relative_error[arrsize];
    for(int i = 0; i < arrsize; i++){ //calculate error
        relative_error[i] = myfloat2double(&mda[i]) -  da[i];
    }
    float sum = 0;
    for(int i = 0; i < arrsize; i++){   //calculate average error
        sum += relative_error[i];
    }
    float average = sum/arrsize;
    int index = random(0, arrsize);
    Serial << "Pre conversion: " << da[index] << " Post conversion: " << myfloat2double(&mda[index]) <<  " Average error: " << average <<  endl;
    double da2[arrsize];
    for(int i = 0; i < arrsize; i++){   //calculate square
        da2[i] = pow(*(da), 2);
    }
    myfloat_type mda2[arrsize];
    for(int i = 0; i < arrsize; i++){   //calculate square
        mult_float(&mda[i], &mda[i], &mda2[i]);
    }
    float relative_error2[arrsize];
    for(int i = 0; i < arrsize; i++){   //calculate error
        relative_error2[i] = myfloat2double(&mda2[i]) - da2[i];
    }
    float sum2 = 0;
    for(int i = 0; i < arrsize; i++){   //calculate average error
        sum2+= relative_error2[i];
    }
    float average2 = sum2/arrsize;
    int index2 = random(0, arrsize);
    Serial << "double mult: " << da2[index2] << " myfloat mult: " << myfloat2double(&mda2[index2]) << " Average error: " << average2 << endl;

    unsigned long time1 = micros();
    for(int i = 0; i < arrsize; i++){
        a*=da[i];
    }
    unsigned long time2 = micros();
    myfloat_type f1;
    doub2mydouble(a, &f1);
    myfloat_type f;
    for(int i = 0; i < arrsize; i++){
        mult_float(&f1, &mda[i], &f);
        memcpy(&f1, &f, 2);
    }
    unsigned long time3 = micros();
    long time_difference = (time3-time2) - (time2-time1);
    Serial << "Time difference: " << time_difference << " ms" << endl;
}