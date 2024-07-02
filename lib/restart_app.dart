import 'package:flutter/services.dart';

/// {@template restart_app}
///
/// RestartApp
/// ----------
/// [RestartApp.restart] method allows to restart the Flutter application.
///
/// The plugin works by creating a new Flutter Engine to start fresh execution
/// of the Dart application entry point, while the underlying platform specific
/// application keeps running.
///
/// {@endtemplate}
class RestartApp {
  /// {@macro restart_app}
  static Future<void> restart() async {
    await _channel.invokeMethod('restart');
  }

  static const MethodChannel _channel = MethodChannel('in.farmako/restart_app');
}
