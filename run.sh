#!/bin/sh
CONFIG_DIR="$HOME/.AndroidStudio3.5"
SDK_DIR="$HOME/.AndroidSdk"
PROJECTS_DIR="$HOME/AndroidStudioProjects"
DOT_GRADLE_DIR="$HOME/.android"
DOT_ANDROID_DIR="$HOME/.android"
mkdir -p "$CONFIG_DIR" "$SDK_DIR" "$PROJECTS_DIR" "$DOT_ANDROID_DIR"

exec docker run --rm -i $AOSP_ARGS \
	--net=host \
	--env=DISPLAY \
	--hostname=studio \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v "$CONFIG_DIR:/home/android/.AndroidStudio3.5" \
	-v "$SDK_DIR:/home/android/Android/Sdk" \
	-v "$PROJECTS_DIR:/home/android/AndroidStudioProjects" \
	-v "$DOT_GRADLE_DIR:/home/android/.gradle" \
	-v "$DOT_ANDROID_DIR:/home/android/.android" \
	-v /dev/bus/usb:/dev/bus/usb \
	--privileged \
	ttytyper/android-studio "${@}"
