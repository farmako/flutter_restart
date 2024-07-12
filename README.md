# restart

A Flutter plugin to restart the application.

The plugin works by creating a new instance of the Flutter Engine. The entry point of the Dart VM is executed again, while the underlying platform specific application keeps running. This is achieved as follows:

### Android

Recreating the `FlutterActivity`.

### iOS

Creating a new instance of `FlutterViewController` & setting it as root view controller of the `UIApplication`.

## Documentation

A single method call allows to terminate the Dart VM & restart execution from the entry point.

```dart

// 🎉

restart();

```

## Setup

### Android

No changes required.

### iOS

Flutter plugins must be registered again with the newly created Flutter Engine. Modify the `ios/Runner/AppDelegate.swift` file in your Flutter project as follows:

```diff
 import Flutter
 import UIKit
+import restart

 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {
     override func application(
         _ application: UIApplication,
         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
     ) -> Bool {
+        // --------------------------------------------------
+        RestartPlugin.generatedPluginRegistrantRegisterCallback = { [weak self] in
+            GeneratedPluginRegistrant.register(with: self!)
+        }
+        // --------------------------------------------------
         GeneratedPluginRegistrant.register(with: self)
         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }

 }
```
