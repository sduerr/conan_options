#pragma once

#ifdef WIN32
  #define buildReqA_EXPORT __declspec(dllexport)
#else
  #define buildReqA_EXPORT
#endif

buildReqA_EXPORT void buildReqA();
