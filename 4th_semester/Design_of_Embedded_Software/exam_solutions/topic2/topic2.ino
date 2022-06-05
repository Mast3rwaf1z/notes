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
        relative_error[i] = mda[i].mantissa-da[i];
    }
    float sum = 0;
    for(int i = 0; i < arrsize; i++){   //calculate average error
        sum += relative_error[i];
    }
    float average = sum/arrsize;
    int index = random(0, arrsize);
    Serial << "Pre conversion: " << da[index] << " Post conversion: " << " Exponent: " << mda[index].exponent << " Mantissa: " << mda[index].mantissa << " Average error: " << average << " Sum: " << sum << endl;
    double da2[arrsize];
    for(int i = 0; i < arrsize; i++){   //calculate square
        da2[i] = pow(*(da), 2);
    }
    for(int i = 0; i < arrsize; i++){

    }

}