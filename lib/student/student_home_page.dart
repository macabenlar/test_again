import 'package:flutter/material.dart';
import 'package:test_again/student/student_drawer.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Add 'const' here
      drawer: const StudentDrawer(),
    );
  }
}
