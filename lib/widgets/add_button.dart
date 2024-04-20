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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Add Story'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter story title',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                        hintText: 'Enter story body',
                      ),
                      maxLines: 4,
                    ),
                  ],
                ),
                actions: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          onPressed(); // Call the onPressed function (to add to Firestore)
                        },
                        child: Icon(Icons.add,),
                        


                      ),
                      SizedBox(width: 10), // Add some space between the buttons
                     
                    ],
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white), // White plus sign icon
          backgroundColor: Colors.green, // Circular button with green background
          shape: CircleBorder(), // Make the button a perfect circle without any border
          mini: true, // Set the button as mini
        ),
      ],
    );
  }
}