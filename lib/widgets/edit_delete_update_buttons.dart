import 'package:flutter/material.dart';

class EditDeleteUpdateButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;

  const EditDeleteUpdateButtons({super.key, 
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
          child: const Text('Edit'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: const Text('Delete'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onUpdatePressed,
          child: const Text('Update'),
        ),
      ],
    );
  }
}
