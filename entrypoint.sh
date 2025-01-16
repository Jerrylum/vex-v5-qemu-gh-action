#! /bin/bash

target=$INPUT_TARGET

echo "Running $target"

STD_OUTPUT=./test-output

touch $STD_OUTPUT

simulator monolith $target | tee $STD_OUTPUT

echo "output=$STD_OUTPUT" >> $GITHUB_OUTPUT
