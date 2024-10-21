import 'package:flutter/material.dart';
import 'package:flutter_digit_recognizer/src/services/recognizer.dart';
import 'package:flutter_digit_recognizer/src/theme/draw_screen_theme.dart';
import 'package:flutter_digit_recognizer/src/utils/constants.dart';
import 'drawing_painter.dart';
import 'models/prediction.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key, required this.getPredictNum});

  final Function(String num) getPredictNum;

  @override
  DrawScreenState createState() => DrawScreenState();
}

class DrawScreenState extends State<DrawScreen> {
  final _points = <Offset>[];

  final _recognizer = Recognizer();
  List<Prediction> _prediction = [];

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  void _initModel() async {
    await _recognizer.loadModel();
  }

  void _recognize() async {

    List<Prediction> prediction = await _recognizer.recognize(_points);
    _prediction = prediction;
    widget.getPredictNum(getPredictNum());
  }

  String getPredictNum() {
    if (_prediction.isEmpty) return "";
    // Sort the predictions by confidence in descending order
    var sortedPredictions = List<Prediction>.from(_prediction);
    sortedPredictions.sort((a, b) => b.confidence.compareTo(a.confidence));
    return sortedPredictions[0].label;
  }

  @override
  Widget build(BuildContext context) {
    final theme = DrawScreenTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width:  Constants.canvasSize + theme.borderWidth * 2,
          height:  Constants.canvasSize + theme.borderWidth * 2,
          decoration: theme.decoration ?? BoxDecoration(
            border: Border.all(
              color: theme.borderColor,
              width: theme.borderWidth,
            ),
          ),
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              Offset localPosition = details.localPosition;
              if (localPosition.dx >= 0 &&
                  localPosition.dx <=  Constants.canvasSize &&
                  localPosition.dy >= 0 &&
                  localPosition.dy <=  Constants.canvasSize) {
                setState(() {
                  _points.add(localPosition);
                });
              }
            },
            onPanEnd: (DragEndDetails details) {
              _recognize();
              setState(() {
                _points.clear();
              });
            },
            child: CustomPaint(
              painter: DrawingPainter(_points),
            ),
          ),
        )
      ],
    );
  }
}
