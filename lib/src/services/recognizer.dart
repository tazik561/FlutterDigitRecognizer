import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/prediction.dart';
import '../utils/constants.dart';

final _canvasCullRect = Rect.fromPoints(
  const Offset(0, 0),
  Offset(Constants.imageSize, Constants.imageSize),
);

final _bgPaint = Paint()..color = Colors.black;

final _whitePaint = Paint()
  ..strokeCap = StrokeCap.round
  ..color = Colors.white
  ..strokeWidth = Constants.strokeWidth;

class Recognizer {
  Interpreter? _interpreter;
  final InterpreterOptions _interpreterOptions = InterpreterOptions();

  Future<void> loadModel() async {
    _interpreter?.close();

    // Load the TFLite model
    _interpreter = await Interpreter.fromAsset(
      'packages/flutter_digit_recognizer/assets/mnist.tflite',
      options: _interpreterOptions,
    );
  }

  Future<List<Prediction>> recognize(List<Offset> points) async {
    final picture = _pointsToPicture(points);
    Uint8List bytes = await _imageToByteListUint8(picture, Constants.mnistImageSize);

    // Run inference
    return _predict(bytes);
  }

  Picture _pointsToPicture(List<Offset> points) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, _canvasCullRect)
      ..scale(Constants.mnistImageSize / Constants.canvasSize);

    // Draw black background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, Constants.imageSize, Constants.imageSize),
      _bgPaint,
    );

    // Draw white lines connecting points
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], _whitePaint);
    }
    return recorder.endRecording();
  }

  Future<Uint8List> _imageToByteListUint8(Picture pic, int size) async {
    final img = await pic.toImage(size, size);
    final imgBytes = await img.toByteData();
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);

    int index = 0;

    for (int i = 0; i < imgBytes!.lengthInBytes; i += 4) {
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }

    return resultBytes.buffer.asUint8List();
  }

  Future<List<Prediction>> _predict(Uint8List inputBytes) async {
    var input = inputBytes.buffer.asUint8List();
    var output = List.filled(10, 0).reshape([1, 10]);

    _interpreter?.run(input, output);

    // Convert the output to a list of Prediction objects
    List<Prediction> predictions = [];
    for (int i = 0; i < output[0].length; i++) {
      predictions.add(Prediction(
        confidence: output[0][i].toDouble(),
        index: i,
        label: _getLabelForIndex(i),
      ));
    }

    return predictions;
  }

  String _getLabelForIndex(int index) {
    return index.toString();
  }

  void dispose() {
    _interpreter?.close();
  }
}
