import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_digit_recognizer/flutter_digit_recognizer_platform_interface.dart';
import 'package:flutter_digit_recognizer/flutter_digit_recognizer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDigitRecognizerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDigitRecognizerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDigitRecognizerPlatform initialPlatform = FlutterDigitRecognizerPlatform.instance;

  test('$MethodChannelFlutterDigitRecognizer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDigitRecognizer>());
  });

  test('getPlatformVersion', () async {

  });
}
