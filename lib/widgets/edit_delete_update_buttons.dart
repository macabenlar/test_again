import 'package:flutter/material.dart';

class EditDeleteUpdateButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;

  const EditDeleteUpdateButtons({
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          child: Text('Edit'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: Text('Delete'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: onUpdatePressed,
          child: Text('Update'),
        ),
      ],
    );
  }
}
