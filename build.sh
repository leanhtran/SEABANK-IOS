#Delete old folder
rm -rf build
rm -rf derived_data

mkdir -p build

# Build lib for simulator
xcodebuild build \
  -scheme SBGoldSDK \
  -derivedDataPath derived_data \
  -arch x86_64 \
  -sdk iphonesimulator \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p build/simulators
cp -r derived_data/Build/Products/Debug-iphonesimulator/ build/simulators

# Build lib for real device
xcodebuild build \
  -scheme SBGoldSDK \
  -derivedDataPath derived_data \
  -arch arm64 \
  -sdk iphoneos \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p build/devices
cp -r derived_data/Build/Products/Debug-iphoneos/ build/devices

# merge 2 lib to framework
xcodebuild -create-xcframework \
    -library build/simulators/libSBGoldSDK.a \
    -library build/devices/libSBGoldSDK.a \
    -output build/SBGoldSDK.xcframework
