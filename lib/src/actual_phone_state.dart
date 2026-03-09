import 'package:flutter/services.dart';
import 'utils/actual_phone_state_status.dart';

/// Provides access to the current phone call state on the device.
///
/// This plugin supports:
///
/// - Android (using `TelecomManager` with `TelephonyManager` fallback)
/// - iOS (using `CXCallObserver`)
///
/// Example:
///
/// ```dart
/// final state = await ActualPhoneState.getPhoneState();
///
/// if (state == ActualPhoneStateStatus.callActive) {
///   print('Call active');
/// }
/// ```
///
/// Note:
/// On Android, the `READ_PHONE_STATE` permission must be granted
/// before calling this method.
class ActualPhoneState {
  static const MethodChannel _channel = MethodChannel('actual_phone_state');

  /// Returns the current phone call state.
  ///
  /// Possible results:
  ///
  /// - [ActualPhoneStateStatus.callActive] – an incoming or ongoing call exists
  /// - [ActualPhoneStateStatus.noCall] – no call is active
  /// - [ActualPhoneStateStatus.unknown] – the state could not be determined
  ///
  /// On Android this method requires the `READ_PHONE_STATE` permission.
  static Future<ActualPhoneStateStatus> getPhoneState() async {
    final String? result = await _channel.invokeMethod<String>('getPhoneState');

    switch (result) {
      case 'callActive':
        return ActualPhoneStateStatus.callActive;

      case 'noCall':
        return ActualPhoneStateStatus.noCall;

      default:
        return ActualPhoneStateStatus.unknown;
    }
  }
}
