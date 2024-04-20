import 'package:flutter/material.dart';

class CustomAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Adjust the width and height for the circular shape
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Shape of the container is a circle
        color: Color.fromRGBO(210, 184, 16, 1), // Green color with full opacity
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.add,
          color: Colors.white, // White plus sign icon
          size: 24, // Increase the size of the icon
        ),
        iconSize: 24, // Adjust the icon size as needed
      ),
    );
  }
}
