import 'package:flutter/material.dart';
import 'package:test_again/widgets/add_quiz.dart'; 
import 'assessment_page.dart'; // Import the assessment_page.dart file

class AssessmentQuizzesPage extends StatefulWidget {
  const AssessmentQuizzesPage({Key? key}) : super(key: key);

  @override
  _AssessmentQuizzesPageState createState() => _AssessmentQuizzesPageState();
}

class _AssessmentQuizzesPageState extends State<AssessmentQuizzesPage> {
  Color passagesColor = const Color.fromARGB(255, 255, 255, 255); // Initial color for Passages
  Color quizzesColor = Colors.yellow; // Initial color for Quizzes set to yellow

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the back button
        backgroundColor: Color(0xFF15A323), // Set the AppBar color
        elevation: 0, // Remove app bar shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentPage(),
                  ),
                );
              },
              child: Text(
                'Passages',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, // Make the text bold
                  color: passagesColor, // Set text color to passagesColor
                ),
              ),
            ),
            Container(
              width: 2, // Width of the line
              height: 20, // Height of the line
              margin: EdgeInsets.symmetric(horizontal: 10), // Adjust margin as needed
              color: Colors.white, // Color of the line
            ),
            GestureDetector(
              onTap: () {
                if (!ModalRoute.of(context)!.isCurrent) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssessmentPage(),
                    ),
                  );
                }
              },
              child: Text(
                'Quizzes',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, // Make the text bold
                  color: quizzesColor, // Set text color to quizzesColor
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomAddButton(
                onPressed: () {
                  // Add your onPressed action for the "Add" button here
                },
              ),
            ),
          ),
          Center(
            child: Text(
              'QUIZZES',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
