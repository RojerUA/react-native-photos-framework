#!/bin/bash

# This script contains common cODE to be run from scripts/objc-test-ios.sh or scripts/objc-test-tvos.sh

if [ -z "$XCODE_BUILD_STEPS" ]; then
  XCODE_BUILD_STEPS="build test"
fi
# TODO: We use xcODEbuild because xctool would stall when collecting info about
# the tests before running them. Switch back when this issue with xctool has
# been resolved.
if [ -n "$XCODE_DESTINATION" ]; then
  xcODEbuild \
    -project $XCODE_PROJECT \
    -scheme $XCODE_SCHEME \
    -sdk $XCODE_SDK \
    -destination "$XCODE_DESTINATION" \
    $XCODE_BUILD_STEPS
else
  xcODEbuild \
    -project $XCODE_PROJECT \
    -scheme $XCODE_SCHEME \
    -sdk $XCODE_SDK \
    $XCODE_BUILD_STEPS
fi
