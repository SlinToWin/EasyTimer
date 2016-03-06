#! /bin/bash

TEST_CMD="xcodebuild -scheme EasyTimerTests -project EasyTimer.xcodeproj build test -sdk iphonesimulator9.2 CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO"

which -s xcpretty
XCPRETTY_INSTALLED=$?

if [[ $TRAVIS || $XCPRETTY_INSTALLED == 0 ]]; then
  eval "${TEST_CMD} | xcpretty"
else
  eval "$TEST_CMD"
fi
