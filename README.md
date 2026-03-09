# actual_phone_state

[![pub package](https://img.shields.io/pub/v/actual_phone_state.svg)](https://pub.dev/packages/actual_phone_state)

A Flutter plugin to get the current phone call state on Android and iOS.

This plugin allows you to check whether there is an active or incoming phone call on the device.

The plugin uses:

- **Android:** `TelecomManager` with `TelephonyManager` fallback
- **iOS:** `CXCallObserver` from CallKit

---

# Features

- Detect if there is an active phone call
- Detect incoming or ongoing calls
- Simple API using an enum instead of raw booleans
- Works in both **foreground** and **background Flutter execution**
- Lightweight implementation without additional dependencies

---

# Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  actual_phone_state: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

# Usage

Import the package:

```dart
import 'package:actual_phone_state/actual_phone_state.dart';
```

Check the current phone state:

```dart
final state = await ActualPhoneState.getPhoneState();

switch (state) {
  case ActualPhoneStateStatus.callActive:
    print("Call is active");
    break;

  case ActualPhoneStateStatus.noCall:
    print("No active call");
    break;

  case ActualPhoneStateStatus.unknown:
    print("Call state could not be determined");
}
```

---

# Return values

The plugin returns the following enum:

```dart
enum ActualPhoneStateStatus {
  unknown,
  noCall,
  callActive,
}
```

| Value        | Description                          |
| ------------ | ------------------------------------ |
| `callActive` | There is an incoming or ongoing call |
| `noCall`     | No phone call is active              |
| `unknown`    | The state could not be determined    |

---

# Android

## Permission

This plugin requires the following permission on Android:

```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

Add this permission to your **AndroidManifest.xml**.

Example:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>

    <application>
        ...
    </application>

</manifest>
```

---

## Runtime permission

On Android, you must request the runtime permission before accessing the phone state.

Example using `permission_handler`:

```dart
await Permission.phone.request();
```

Note: `permission_handler` is **not required by this plugin**.  
You may use any permission management solution you prefer.

---

## Foreground vs Background behavior

When the application is running in the **foreground**, you should request the phone permission before calling the plugin.

When running in **background execution** (for example inside a Firebase background message handler), it is **not possible to request runtime permissions**.

In this situation the plugin will simply return:

```
ActualPhoneStateStatus.unknown
```

if the permission has not been granted previously.

Therefore it is recommended to request the permission while the application is running in the foreground.

---

# iOS

On iOS the plugin uses **CallKit (`CXCallObserver`)** to determine if there is an active call.

No additional permissions are usually required.

However, due to system restrictions imposed by iOS, the result may depend on system state and application lifecycle.

---

## iOS Simulator limitations

Phone call detection **does not work reliably on the iOS Simulator**, because the simulator does not provide a real telephony stack.

Testing on a **real iPhone device** is recommended.

---

# Example

See the `/example` directory for a complete working example.

---

# Platform support

| Platform | Supported |
| -------- | --------- |
| Android  | ✅        |
| iOS      | ✅        |
| Web      | ❌        |
| macOS    | ❌        |
| Windows  | ❌        |
| Linux    | ❌        |

