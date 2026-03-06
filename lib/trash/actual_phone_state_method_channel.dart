import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'actual_phone_state_platform_interface.dart';

/// An implementation of [ActualPhoneStatePlatform] that uses method channels.
class MethodChannelActualPhoneState extends ActualPhoneStatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('actual_phone_state');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
