this is read me file !

issue list:
https://docs.google.com/document/d/1Py51u0vlNzTWXsUJGpe1Ghbw4kRyVmN1z3Ii5VpW7xc/edit

https://docs.google.com/document/d/1ESNtMD2Qwimtwv0pPbcpLEq72J8uN1uN0iVUdL9fQ7M/edit

flutterwave test card:
Visa Card 3DS authentication 2	4242424242424242	812	3310	01/31	12345


This might be overkill, but this is the best way I know to perform the cleanest pod install and ensure that you have no lingering pod cache issues or misconfigured Xcode settings:

cd ios
rm -rf Podfile.lock
rm -rf Pods
rm -rf pubspec.lock
pod repo update
pod cache clean --all
pod deintegrate
pod setup
pod install --repo-update




flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi

flutter run -d chrome --web-hostname localhost --web-port 5000