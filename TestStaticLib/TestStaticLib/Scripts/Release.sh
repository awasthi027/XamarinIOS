# Type a script or drag a script file from yo######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="${PROJECT_NAME}"
#STEP 1 Getting framwork name same as lib name.
echo 👍 1 Bulding ${PROJECT_NAME} for device

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator"

echo 👍 2 Simulator Lib path:- ${SIMULATOR_LIBRARY_PATH}

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos"

echo 👍 3 Device Lib path:- ${DEVICE_LIBRARY_PATH}

UNIVERSAL_LIBRARY_DIR="Universal"

FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}"

echo 👍 4 Uinversal Lib path:- ${FRAMEWORK}

# Build Frameworks

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphonesimulator -configuration ${CONFIGURATION} OBJROOT="${OBJROOT}/DependentBuilds"

xcodebuild -target "${PROJECT_NAME}" -scheme "${PROJECT_NAME}" -sdk iphoneos -configuration ${CONFIGURATION}  OBJROOT="${OBJROOT}/DependentBuilds"

# Create directory for universal
######################

rm -rf "${UNIVERSAL_LIBRARY_DIR}"

echo 👍 5 Remove Old Universal Lib from path before creating.

#mkdir "${UNIVERSAL_LIBRARY_DIR}"

if [ ! -d "${UNIVERSAL_LIBRARY_DIR}" ]; then
mkdir "${UNIVERSAL_LIBRARY_DIR}"
echo 👍 6 Created Universal Directory at path:${FRAMEWORK}.
# Control will enter here if $DIRECTORY doesn't exist.
fi
#mkdir "${FRAMEWORK}"
if [ ! -d "${FRAMEWORK}" ]; then
mkdir "${FRAMEWORK}"
# Control will enter here if $DIRECTORY doesn't exist.
fi

######################
# Copy files Framework
######################

#cp -r "${DEVICE_LIBRARY_PATH}/." "${FRAMEWORK}"


######################
# Make an universal binary
######################
echo 👍 7 Below command will copy and paste universal directory at project directiory

lipo "${SIMULATOR_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" "${DEVICE_LIBRARY_PATH}/lib${FRAMEWORK_NAME}.a" -create -output "${FRAMEWORK}/lib${FRAMEWORK_NAME}.a" | echo

echo 👍 8 Created Universal directory at path:- ${FRAMEWORK}

#ur workspace to insert its path.


