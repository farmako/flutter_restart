import Flutter
import UIKit

public class RestartPlugin: NSObject, FlutterPlugin {
    public static var generatedPluginRegistrantRegisterCallback: () -> Void = {
        NSLog("WARNING: generatedPluginRegistrantRegisterCallback is not assigned by the AppDelegate.")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "in.farmako/restart", binaryMessenger: registrar.messenger())
        let instance = RestartPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "restart":
            let project = FlutterDartProject()
            UIApplication.shared.keyWindow?.rootViewController = FlutterViewController(
                project: project,
                nibName: nil,
                bundle: nil
            )
            RestartPlugin.generatedPluginRegistrantRegisterCallback()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
