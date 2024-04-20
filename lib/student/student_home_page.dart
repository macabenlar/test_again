import 'package:flutter/material.dart';
import 'package:test_again/student/student_drawer.dart';
import '../constant.dart';
import 'student_assessment.dart'; // Import the student_assessment.dart file

class StudentHomePage extends StatefulWidget {
 const StudentHomePage({Key? key}) : super(key: key); // Convert 'key' to a super parameter

 @override
 State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralColor,
      appBar: AppBar(
        title: const Text('', style: TextStyle(color: neutralColor)),
        backgroundColor: neutralColor,
        shadowColor: const Color.fromARGB(255, 0, 0, 0), // Use 'const' with the constructor
      ),
      drawer: const StudentDrawer(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentAssessment()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Make the corners rounded
            child: Stack(
              alignment: Alignment.center,
                children: [
                  Image.asset(
                  'assets/images/Assessment.png',
                  width: 200, // Adjust the width as needed
                  height: 100, // Adjust the height as needed to maintain the aspect ratio of the image
                  fit: BoxFit.cover, // Use BoxFit.cover to make the image fill the container
                  ),
                  Text(
                  'Assessment',
                  style: TextStyle(
                      color: Colors.white, // Adjust the text color as needed
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