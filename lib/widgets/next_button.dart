import 'package:flutter/material.dart';
import '../constant.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.nextQuestion}) : super(key: key);
  final VoidCallback nextQuestion;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // Adjust the width as needed
      height: 40, // Adjust the height as needed
      child: FloatingActionButton(
        onPressed: nextQuestion,
        backgroundColor: neutralColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Text(
            'Next Question',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16), // Adjust font size as needed
          ),
        ),
      ),
    );
  }
}
