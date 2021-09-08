#include <iostream>
#include "pkgA.h"

void pkgA(){
    #ifdef NDEBUG
    std::cout << "pkgA/0.1: Hello World Release!" <<std::endl;
    #else
    std::cout << "pkgA/0.1: Hello World Debug!" <<std::endl;
    #endif
}
