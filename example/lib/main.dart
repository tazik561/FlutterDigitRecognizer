import 'package:flutter/material.dart';
import 'package:flutter_digit_recognizer/flutter_digit_recognizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RecognizerScreen());
  }
}

class RecognizerScreen extends StatefulWidget {
  const RecognizerScreen({super.key});

  @override
  State<RecognizerScreen> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  String predictNumber = ""; // Store the predicted number string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "This model is trained on the MNIST dataset for handwritten digit recognition. To achieve accurate predictions, please write each digit clearly within the canvas size provided. Ensure that your digits are well-defined. The more clearly you write, the better the prediction will be!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: DrawScreenTheme(
                data: DrawScreenThemeData(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
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
                    debugPrint("Predicted Number: $num");
                    setState(() {
                      // Append the predicted number to the existing string
                      predictNumber += num; // Concatenate digits
                    });
                  },
                ),
              ),
            ),
            Text(
              _formatNumber(predictNumber), // Format for display
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format the number string with commas
  String _formatNumber(String number) {
    if (number.isEmpty) return number;
    final buffer = StringBuffer();
    int count = 0;

    for (int i = number.length - 1; i >= 0; i--) {
      buffer.write(number[i]);
      count++;
      // Add a comma after every three digits, but not at the end
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }

    // Reverse the buffer to get the correct order
    return buffer.toString().split('').reversed.join('');
  }
}
