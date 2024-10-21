import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_digit_recognizer_method_channel.dart';

abstract class FlutterDigitRecognizerPlatform extends PlatformInterface {
  /// Constructs a FlutterDigitRecognizerPlatform.
  FlutterDigitRecognizerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDigitRecognizerPlatform _instance = MethodChannelFlutterDigitRecognizer();

  /// The default instance of [FlutterDigitRecognizerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDigitRecognizer].
  static FlutterDigitRecognizerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDigitRecognizerPlatform] when
  /// they register themselves.
  static set instance(FlutterDigitRecognizerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
