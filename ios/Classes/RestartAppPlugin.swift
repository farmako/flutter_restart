import Flutter
import UIKit

public class RestartAppPlugin: NSObject, FlutterPlugin {
    public static var generatedPluginRegistrantRegisterCallback: () -> Void = {
        NSLog("WARNING: generatedPluginRegistrantRegisterCallback is not assigned by the AppDelegate.")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "in.farmako/restart_app", binaryMessenger: registrar.messenger())
        let instance = RestartAppPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "restart":
            let flutterViewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
            UIApplication.shared.keyWindow?.rootViewController = FlutterViewController(
                project: nil,
                nibName: nil,
                bundle: nil
            )
            RestartAppPlugin.generatedPluginRegistrantRegisterCallback()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
