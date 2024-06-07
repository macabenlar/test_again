import 'package:flutter/material.dart';
import 'package:test_again/models/student_model.dart'; // Import your Student model class

class StudentDetailPage extends StatelessWidget {
  final Student student;

  const StudentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: const Color(0xFF15A323), // Optional: Set the AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${student.firstName.isNotEmpty ? student.firstName : 'N/A'} ${student.lastName.isNotEmpty ? student.lastName : 'N/A'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Grade: ${student.gradeLevel.isNotEmpty ? student.gradeLevel : 'N/A'}'),
            const SizedBox(height: 10),
            Text('Gender: ${student.gender.isNotEmpty ? student.gender : 'N/A'}'),
            const SizedBox(height: 10),
            student.profilePictureUrl.isNotEmpty
                ? Image.network(student.profilePictureUrl)
                : Container(), // Only display image if the URL is not empty
            const SizedBox(height: 20),
            const Text(
              'Progress:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...student.progress.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quiz ID: ${entry.key}'),
                  Text('Score: ${entry.value['score']}'),
                  Text('Completed At: ${entry.value['completedAt']}'),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
