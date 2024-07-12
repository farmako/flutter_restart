import 'package:flutter/services.dart';

/// {@template restart}
///
/// package:restart
/// ---------------
/// [restart] method allows to restart the Flutter application.
///
/// The plugin works by creating a new instance of the Flutter Engine. The
/// entry point of the Dart VM is executed again, while the underlying platform
/// specific application keeps running.
///
/// {@endtemplate}
Future<void> restart() => _channel.invokeMethod('restart');

const _channel = MethodChannel('in.farmako/restart');
