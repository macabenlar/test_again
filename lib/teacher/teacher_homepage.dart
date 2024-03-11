
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test_again/teacher/teacher_drawer.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const TeacherDrawer(),
      // body: ,
    );
  }
}