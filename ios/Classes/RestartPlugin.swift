import Flutter
import UIKit

public class RestartPlugin: NSObject, FlutterPlugin {
    @objc public static var generatedPluginRegistrantRegisterCallback: () -> Void = {
        NSLog("WARNING: generatedPluginRegistrantRegisterCallback is not assigned by the AppDelegate.")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "in.farmako/restart", binaryMessenger: registrar.messenger())
        let instance = RestartPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String:Any]
        switch call.method {
        case "restart":
            let args = arguments?["args"] as? [String]
            let engine = FlutterEngine(name: "io.flutter.flutter.app")
            engine.run(
                withEntrypoint: nil,
                libraryURI: nil,
                initialRoute: nil,
                entrypointArgs: args
            )
            UIApplication.shared.keyWindow?.rootViewController = FlutterViewController(
                engine: engine,
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
