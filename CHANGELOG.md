# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## 1.0.0

### Added

- Initial stable release of the `actual_phone_state` plugin
- Android implementation using `TelecomManager` with `TelephonyManager` fallback
- iOS implementation using `CXCallObserver`
- Enum-based API for representing the phone call state:
  - `ActualPhoneStateStatus.callActive`
  - `ActualPhoneStateStatus.noCall`
  - `ActualPhoneStateStatus.unknown`
- Public API method:
  - `ActualPhoneState.getPhoneState()`
- Example application demonstrating plugin usage
