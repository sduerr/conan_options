#!/bin/bash

ROOT_DIR=".."
LOCKFILE_INIT=pkgA-lockcreate.lock
LOCKFILE_INST=pkgA-inst.lock
SINGLE_CALL=""

set -ex

while getopts "s" option;
do
    case "${option}" in
        s) SINGLE_CALL="true";;
    esac
done

# Clean up
conan remove -f '*'
rm -f ${LOCKFILE_INIT} ${LOCKFILE_INST}

conan export ${ROOT_DIR}/pkgA/conanfile.py pkgA/0.1@_/_
conan export ${ROOT_DIR}/buildReqA/conanfile.py buildReqA/0.1@_/_

conan lock create --reference pkgA/0.1@_/_ --build missing --lockfile-out ${LOCKFILE_INIT} --profile ${ROOT_DIR}/profiles/host --profile:build=${ROOT_DIR}/profiles/build

#########################
# Works
if [[ -n "$SINGLE_CALL" ]]; then
    echo "Single call option"
    conan install pkgA/0.1@_/_ --lockfile ${LOCKFILE_INIT} --lockfile-out=${LOCKFILE_INST} --build=missing
else
#########################
# The step-by-step invocation leads to "ERROR: buildReqA/0.1: Locked options do not match computed options"
    echo "Multiple call option"
    conan lock build-order ${LOCKFILE_INIT}
    conan install buildReqA/0.1@_/_ --lockfile=${LOCKFILE_INIT} --lockfile-out=${LOCKFILE_INST} --build=buildReqA/0.1 --build-require --lockfile-node-id=2
    conan install pkgA/0.1@_/_ --lockfile=${LOCKFILE_INIT} --lockfile-out=${LOCKFILE_INST} --build=pkgA/0.1
fi
