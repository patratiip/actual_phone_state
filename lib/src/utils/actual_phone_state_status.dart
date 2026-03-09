/// Represents the current phone call state on the device.
///
/// This enum is returned by [ActualPhoneState.getPhoneState].
enum ActualPhoneStateStatus {
  /// The phone state could not be determined.
  ///
  /// This may happen if the required permissions are not granted
  /// or if the platform restricts access to the call state.
  unknown,

  /// No phone call is currently active.
  noCall,

  /// There is an active or incoming phone call.
  callActive,
}