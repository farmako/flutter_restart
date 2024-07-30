import 'package:flutter/services.dart';

/// {@template restart}
///
/// # package:restart
///
/// [restart] method allows to restart the Flutter application.
///
/// The plugin works by creating a new instance of the Flutter Engine. The entry
/// point of the Dart VM is executed again, while the underlying platform
/// specific application keeps running.
///
/// Entry point arguments can be specified by providing the [args] argument in
/// the method call. The value will be passed to the main method of the Dart VM
/// as [List<String>]. The default value is an empty list.
///
/// ### Example
///
/// Restart the application:
///
/// ```dart
/// restart();
/// ```
///
/// Restart the application with arguments:
///
/// ```dart
/// restart(args: ['--route', '/home']);
///
/// ...
///
/// void main(List<String> args) {
///   // Prints ['--route', '/home'].
///   print(args);
/// }
/// ```
///
/// {@endtemplate}
Future<void> restart({List<String> args = const []}) {
  return _channel.invokeMethod(
    'restart',
    {
      'args': args,
    },
  );
}

const _channel = MethodChannel('in.farmako/restart');
