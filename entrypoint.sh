#! /bin/bash

target=$INPUT_TARGET

echo "Running $target"

STD_OUTPUT=$(mktemp)

simulator monolith $target | tee $STD_OUTPUT

echo "::set-output name=output::$STD_OUTPUT"
