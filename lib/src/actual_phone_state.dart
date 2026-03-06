import 'package:flutter/services.dart';
import 'utils/actual_phone_state_status.dart';

class ActualPhoneState {
  static const MethodChannel _channel =
      MethodChannel('actual_phone_state');

  static Future<ActualPhoneStateStatus> getPhoneState() async {
    final String? result =
        await _channel.invokeMethod<String>('getPhoneState');

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