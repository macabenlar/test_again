import 'package:flutter/material.dart';

class EditDeleteUpdateButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;

  const EditDeleteUpdateButtons({
    Key? key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          child: Text('Edit'),
        ),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: Text('Delete'),
        ),
        ElevatedButton(
          onPressed: onUpdatePressed,
          child: Text('Update'),
        ),
      ],
    );
  }
}
