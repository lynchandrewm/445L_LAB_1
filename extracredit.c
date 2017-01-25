// extracredit.c
// Runs on TM4C123
// Andrew Lynch
// January 24, 2017
// Runs c code for lab1 extra credit for run-time testing
// 16360
// Dylan
// January 24, 2017
// No hardware necessary

#include <stdio.h>
#include <stdint.h>
#include "PLL.h"
#include "inc/tm4c123gh6pm.h"


// version 1: C floating point
// run with compiler options selected for floating-point hardware
volatile float Tfloat;    // temperature in C
volatile uint32_t N; // 12-bit ADC value
void Test1(void){
  for(N=0; N<4096; N++){
    Tfloat = 10.0+ 0.009768*N; 	
  }
}


// version 2: C fixed-point
volatile uint32_t Tfixed;    // temperature in 0.01 C
//volatile uint32_t N;    // 12-bit ADC value
void Test2(void){
  for(N=0; N<4096; N++){
    Tfixed = 1000+ (125*N+64)>>7; 	
  }
}
