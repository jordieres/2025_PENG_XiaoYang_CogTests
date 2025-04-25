# 2025_PENG_XiaoYang_CogTests

Repo for Cognitive Tests

## Create Splash Screen

```bash
dart run flutter_native_splash:create
```

## Generate Launcher Icons

```bash
flutter pub run flutter_launcher_icons
```

## Build Android Apk

### Debug

```bash
flutter build apk --debug
```

### Release

```bash
flutter build apk --release
```

### Build App Bundle

Before building add the following to `android/local.properties`:

```properties
storeFile=YOUR_PATH_TO_KEYSTORE
storePassword=YOUR_KEYSTORE_PASSWORD
keyAlias=YOUR_KEY_ALIAS
keyPassword=YOUR_KEY_PASSWORD
```

Then run the following command to build the app bundle:

```bash
flutter build appbundle --release
```

You can find it in the following directory:

`Windows:`
```bash
start .\\build\\app\\outputs\\bundle\\release\\ 
```

`macOS/Linux:`
```bash
open ./build/app/outputs/bundle/release/
```