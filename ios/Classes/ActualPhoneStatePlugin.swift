import Flutter
import UIKit
import CallKit

public class ActualPhoneStatePlugin: NSObject, FlutterPlugin {

  private let callObserver = CXCallObserver()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "actual_phone_state",
      binaryMessenger: registrar.messenger()
    )

    let instance = ActualPhoneStatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPhoneState":
      let hasActiveCall = callObserver.calls.contains { !$0.hasEnded }

      if hasActiveCall {
        result("callActive")
      } else {
        result("noCall")
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}