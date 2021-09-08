#pragma once

#ifdef WIN32
  #define pkgA_EXPORT __declspec(dllexport)
#else
  #define pkgA_EXPORT
#endif

pkgA_EXPORT void pkgA();
