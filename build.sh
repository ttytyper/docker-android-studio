#!/bin/sh
exec docker build --network=host -t ttytyper/android-studio "$(dirname "$0")" "${@}"
