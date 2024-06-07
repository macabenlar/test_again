import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_drawer.dart';
import '../constant.dart';
import 'student_assessment.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String studentId = user?.uid ?? '';

    return Scaffold(
      backgroundColor: neutralColor,
      appBar: AppBar(
        title: const Text('', style: TextStyle(color: neutralColor)),
        backgroundColor: neutralColor,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      drawer: StudentDrawer(studentId: studentId),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentAssessment(studentId: studentId)),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Assessment.png',
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Assessment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
