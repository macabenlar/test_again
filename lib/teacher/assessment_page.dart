import 'package:flutter/material.dart';
import 'package:test_again/widgets/add_button.dart'; // Import the CustomAddButton widget
import 'assessment_quizzes.dart'; // Import the assessment_quizzes.dart file
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_core/firebase_core.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({Key? key}) : super(key: key);

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  Color passagesColor = Colors.yellow; // Set initial color for Passages text to yellow
  Color quizzesColor = Colors.white; // Initial color for Quizzes
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isAddingStory = false;

  void addStory() {
    // Example code to add a story to Firestore
    FirebaseFirestore.instance.collection('stories').add({
      'title': titleController.text,
      'body': bodyController.text,
    }).then((value) {
      // Successfully added the story
      print('Story added successfully!');
      // Clear the text fields after adding the story
      titleController.clear();
      bodyController.clear();
      // Hide the input fields and show the "Add" button again
      setState(() {
        isAddingStory = false;
      });
    }).catchError((error) {
      // Error adding the story
      print('Error adding story: $error');
    });
  }

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
                // Do nothing when clicking on "Passages"
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentQuizzesPage(),
                  ),
                );
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
              child: CustomAddButton( // Use CustomAddButton widget instead of ElevatedButton
                onPressed: () {
                  setState(() {
                    isAddingStory = true;
                  });
                },
                titleController: titleController,
                bodyController: bodyController,
              ),
            ),
          ),
          Center(
            child: Text(
              'Stories',
              style: TextStyle(fontSize: 24),
            ),
          ),
          if (isAddingStory)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter story title',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: bodyController,
                        decoration: InputDecoration(
                          hintText: 'Enter story body',
                        ),
                        maxLines: 4,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: addStory,
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
