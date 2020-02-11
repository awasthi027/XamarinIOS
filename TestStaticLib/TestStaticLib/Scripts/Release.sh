# Type a script or drag a script file from yo######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="${PROJECT_NAME}"
#STEP 1 Getting framwork name same as lib name.
echo 👍 1 Building Lib  ${PROJECT_NAME} for Universal

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

echo 👍 2 Simulator Lib path:- ${SIMULATOR_LIBRARY_PATH}

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos"

echo 👍 3 Device Lib path:- ${DEVICE_LIBRARY_PATH}

Universal_Dir_Name="Universal"

Universal_Directory_Path=${SRCROOT}

Destination_Path="${Universal_Directory_Path}/${Universal_Dir_Name}"

echo 👍 4 Uinversal Lib path:- ${Destination_Path}

echo 👍 Start Building Library
# Build Frameworks

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphonesimulator -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphoneos -configuration ${CONFIGURATION}  OBJROOT="${OBJROOT}/DependentBuilds"

# Create directory for universal
######################
echo 👍 End Building Library

rm -rf "${Destination_Path}"
echo 👍 6 Deleted directory from path ifs exist:- ${Destination_Path}.


echo 👍 5 Remove Old Universal Lib from path before creating New one.

#mkdir "${UNIVERSAL_LIBRARY_DIR}"

if [ ! -d "${Destination_Path}" ]; then
mkdir "${Destination_Path}"
echo 👍 6 Created Universal Directory at path:- ${Destination_Path}.
# Control will enter here if $DIRECTORY doesn't exist.
fi

######################
# Make an universal binary
######################
echo 👍 7 Belew commands will merge Simulator and Device Library which we can use debug on device and Simulator

lipo "${SIMULATOR_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" "${DEVICE_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" -create -output "${Destination_Path}/lib${FRAMEWORK_NAME}.a" | echo

echo ⛳✅ 8 Created Universal Lib at path:- ${Destination_Path}.

#ur workspace to insert its path.


