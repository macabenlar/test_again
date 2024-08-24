import 'package:flutter/material.dart';
import 'package:test_again/teacher/student_list_page.dart';
import 'package:test_again/teacher/teacher_drawer.dart';
import 'package:test_again/teacher/assessment_page.dart';
import 'package:test_again/widgets/background.dart'; // Import the Background widget
import 'package:firebase_auth/firebase_auth.dart';

class TeacherHomePage extends StatefulWidget {
  final String teacherId; // Add teacherId parameter

  const TeacherHomePage({super.key, required this.teacherId});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _backButtonCount = 0;

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, ModalRoute.withName('/')); // Navigate to the initial route
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_backButtonCount == 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press back again to log out'),
          ));
          setState(() {
            _backButtonCount++;
          });
          return false; // Prevent back navigation
        } else {
          await _confirmLogout();
          return false; // Prevent back navigation
        }
      },
      child: Background(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home Page',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          drawer: TeacherDrawer(teacherId: widget.teacherId), // Pass teacherId here
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AssessmentPage()),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Assessment.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Assessment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentListPage(teacherId: widget.teacherId)),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Student.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Student List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
