
[![pub package](https://img.shields.io/pub/v/flutter_html.svg)](https://pub.dev/packages/flutter_digit_recognizer)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/Sub6Resources/flutter_html/blob/master/LICENSE)


# Flutter Digit Recognizer

A Flutter library for recognizing handwritten digits using a pre-trained model based on the MNIST dataset. This library provides an easy-to-use interface for integrating digit recognition capabilities into your Flutter applications.

## Background

I created this library to provide an efficient and user-friendly way to incorporate digit recognition into Flutter applications. The model is trained on the MNIST dataset, which includes a vast collection of handwritten digits, ensuring accurate predictions for users.

## Features

- **Handwritten Digit Recognition**: Recognize digits drawn on a canvas.
- **Customizable Drawing Area**: Configure the drawing area’s appearance and size.
- **Lightweight and Easy to Integrate**: Seamlessly add this library to your existing Flutter projects.

## Installation

To use the Flutter Digit Recognizer library, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_digit_recognizer: ^0.0.2
```

Then run :
```dart
flutter pub get
```
## Usage

Import the library:
```dart
import 'package:flutter_digit_recognizer/flutter_digit_recognizer.dart';
```

Use the DrawScreen widget in your app:

```dart
 DrawScreenTheme(
      data: DrawScreenThemeData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.blueAccent,
            width: 4.0,
          ),
        ),
      ),
      child: DrawScreen(
        getPredictNum: (String num) {
          setState(() {
            predictNumber = num;
          });
        },
      ),
```

Basic Setup

Drawing Area Configuration:

```dart
DrawScreenThemeData(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    border: Border.all(
      color: Colors.greenAccent,
      width: 4.0,
    ),
  ),
)
```

Handling Predictions
he getPredictNum callback provides the recognized digit. You can use this callback to update your UI or process the prediction further.

```dart
getPredictNum: (String num) {
    debugPrint("Predicted Number: $num");
    setState(() {
    predictNumber = num;
    });
},

```

## Important Note

I trained this model on the MNIST dataset for handwritten digit recognition, which means that for accurate predictions, you should write your digits within the designated canvas size. Ensure that you write each digit clearly.The model's predictions are based on the MNIST dataset, and results may vary based on the quality of input data.


## License

`Flutter Digit Recognizer Plugin` is released under the MIT License. See the [LICENSE](./LICENSE) file for details.



