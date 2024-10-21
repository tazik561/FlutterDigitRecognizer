import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_digit_recognizer_platform_interface.dart';

/// An implementation of [FlutterDigitRecognizerPlatform] that uses method channels.
class MethodChannelFlutterDigitRecognizer extends FlutterDigitRecognizerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_digit_recognizer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
