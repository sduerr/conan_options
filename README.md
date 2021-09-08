# Conan option handling bug demo

This repo shows a possible bug in Conan which does not handle options correctly.
This has been tested with Conan 1.40.0

This repository contains a Conan recipe pkgA, which depends on a build requirement buildReqA.
In order to override the value of the `options.shared` of buildReqA, which is set to "True" by the profile, it sets the value to "False" in its `configure()` method.
Conan correctly handles this configuration when building everything in a single call.
However, when building buildReqA by itself using the lockfile, as it would be done in e.g. a continuous build, Conan generates an error.

To reproduce the single call situation, invoke:

    cd script
    ./call_conan.sh -s

To reproduce the not working step-by-step mode, invoke:

    cd script
    ./call_conan.sh

