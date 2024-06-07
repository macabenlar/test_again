import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'assessment_page.dart'; // Import for AssessmentPage
import '../widgets/custom_add_button.dart'; // Import for CustomAddButton
import '../Screens/create_quiz_screen.dart'; // Import for CreateQuizScreen
import '../Screens/edit_quiz_screen.dart'; // Import for EditQuizScreen

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
        backgroundColor: const Color(0xFF15A323), // Set the AppBar color
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
              margin: const EdgeInsets.symmetric(horizontal: 10), // Adjust margin as needed
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
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomAddButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateQuizScreen(storyId: 'sample_story_id'), // Sample story ID
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0), // Add spacing between the button and the quizzes
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Quizzes').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var quizzes = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: quizzes.length,
                    itemBuilder: (context, index) {
                      var quiz = quizzes[index];
                      var title = quiz.data().containsKey('title') ? quiz['title'] : 'No Title'; // Handle missing title field
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Proper spacing and margin
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditQuizScreen(quizId: quiz.id),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(25.0), // More rounded corners
                            ),
                            child: Center( // Center the text
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
