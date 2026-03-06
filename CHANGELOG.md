# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## 0.0.1

Initial release of the **actual_phone_state** plugin.

### Added

- Android support using `TelecomManager` with `TelephonyManager` fallback
- iOS support using `CXCallObserver` from CallKit
- `ActualPhoneState.getPhoneState()` API
- Enum-based state response:
  - `ActualPhoneStateStatus.callActive`
  - `ActualPhoneStateStatus.noCall`
  - `ActualPhoneStateStatus.unknown`
- Basic example application
