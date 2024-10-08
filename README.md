# restart

A Flutter plugin to restart the application.

The plugin works by creating a new instance of the Flutter Engine. The entry point of the Dart VM is executed again, while the underlying platform specific application keeps running. This is achieved as follows:

### Android

Recreating the `FlutterActivity`.

### iOS

Creating a new instance of `FlutterViewController` & setting it as root view controller of the `UIApplication`.

## Installation

Add package to the dependencies section of the `pubspec.yaml`:

```yaml
dependencies:
  restart: ^1.0.0
```

## Documentation

A single method call allows to terminate the Dart VM & restart execution from the entry point.

```dart
import 'package:restart/restart.dart';

// 🎉
restart();
```

## Setup

### Android

Modify the `MainActivity.kt` file in your Flutter project as follows:

```diff
+import android.content.Context
+import app.farmako.restart.RestartPlugin
 import io.flutter.embedding.android.FlutterActivity

-class MainActivity: FlutterActivity()
+class MainActivity: FlutterActivity() {
+    override fun provideFlutterEngine(context: Context) = RestartPlugin.provideFlutterEngine()
+}
```

### iOS

Modify the `AppDelegate.swift` file in your Flutter project as follows:

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
