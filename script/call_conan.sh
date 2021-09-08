#!/bin/bash

ROOT_DIR=".."
LOCKFILE_INIT=pkgA-lockcreate.lock
LOCKFILE_INST=pkgA-inst.lock

set -ex
 
# Clean up
conan remove -f '*'
rm -f ${LOCKFILE_INIT} ${LOCKFILE_INST}

conan export ${ROOT_DIR}/pkgA/conanfile.py pkgA/0.1@_/_
conan export ${ROOT_DIR}/buildReqA/conanfile.py buildReqA/0.1@_/_

conan lock create --reference pkgA/0.1@_/_ --build missing --lockfile-out ${LOCKFILE_INIT} --profile ${ROOT_DIR}/profiles/host

#########################
# Works
#conan install pkgA/0.1@_/_ --lockfile ${LOCKFILE_INIT} --lockfile-out=${LOCKFILE_INST} --build=missing

#########################
# Works, too (no build profile)
conan lock build-order ${LOCKFILE_INIT}

conan install buildReqA/0.1@_/_ --lockfile=${LOCKFILE_INIT} --build=buildReqA/0.1
conan install pkgA/0.1@_/_ --lockfile=${LOCKFILE_INIT} --build=pkgA/0.1

