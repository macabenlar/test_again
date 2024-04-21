import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  const CustomAddButton({
    Key? key,
    required this.onPressed,
    required this.titleController,
    required this.bodyController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FloatingActionButton(
          onPressed: onPressed, // Call the onPressed callback directly
          child: Icon(Icons.add, color: Colors.white), // White plus sign icon
          backgroundColor: Colors.green, // Circular button with green background
          shape: CircleBorder(), // Make the button a perfect circle without any border
          mini: true, // Set the button as mini
        ),
      ],
    );
  }
}
