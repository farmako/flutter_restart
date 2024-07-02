import Flutter
import UIKit
import restart_app

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // --------------------------------------------------
        RestartAppPlugin.generatedPluginRegistrantRegisterCallback = { [weak self] in
            GeneratedPluginRegistrant.register(with: self!)
        }
        // --------------------------------------------------
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
