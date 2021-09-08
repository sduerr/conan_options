#include <iostream>
#include "buildReqA.h"

void buildReqA(){
    #ifdef NDEBUG
    std::cout << "buildReqA/0.1: Hello World Release!" <<std::endl;
    #else
    std::cout << "buildReqA/0.1: Hello World Debug!" <<std::endl;
    #endif
}
