import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_drawer.dart';
import '../constant.dart';
import 'student_assessment.dart';
import 'package:test_again/widgets/background.dart'; // Make sure to import the Background widget

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Do you want to log out?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Dismiss the dialog
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(true); // Close the dialog and allow the pop
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String studentId = user?.uid ?? '';

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent, // Make scaffold transparent to show the background
          appBar: AppBar(
            title: const Text('', style: TextStyle(color: neutralColor)),
            backgroundColor: Colors.transparent, // Transparent AppBar to show the background
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
        ),
      ),
    );
  }
}
