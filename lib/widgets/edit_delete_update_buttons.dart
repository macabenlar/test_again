import 'package:flutter/material.dart';

class EditDeleteUpdateButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;

  const EditDeleteUpdateButtons({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          child: const Text('Edit'),
        ),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: const Text('Delete'),
        ),
        ElevatedButton(
          onPressed: onUpdatePressed,
          child: const Text('Update'),
        ),
      ],
    );
  }
}
