import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'actual_phone_state_method_channel.dart';

abstract class ActualPhoneStatePlatform extends PlatformInterface {
  /// Constructs a ActualPhoneStatePlatform.
  ActualPhoneStatePlatform() : super(token: _token);

  static final Object _token = Object();

  static ActualPhoneStatePlatform _instance = MethodChannelActualPhoneState();

  /// The default instance of [ActualPhoneStatePlatform] to use.
  ///
  /// Defaults to [MethodChannelActualPhoneState].
  static ActualPhoneStatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ActualPhoneStatePlatform] when
  /// they register themselves.
  static set instance(ActualPhoneStatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
