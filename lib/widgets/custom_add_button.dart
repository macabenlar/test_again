import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Adjust the width and height for the circular shape
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // Shape of the container is a circle
        color: Color.fromRGBO(9, 214, 26, 1), // Green color with full opacity
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          color: Colors.white, // White plus sign icon
          size: 24, // Increase the size of the icon
        ),
        iconSize: 24, // Adjust the icon size as needed
      ),
    );
  }
}
