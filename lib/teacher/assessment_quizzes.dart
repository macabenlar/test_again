import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'assessment_page.dart'; // Import for AssessmentPage
import '../widgets/custom_add_button.dart'; // Import for CustomAddButton
import '../Screens/create_quiz_screen.dart'; // Import for CreateQuizScreen
import '../Screens/edit_quiz_screen.dart'; // Import for EditQuizScreen
import '../widgets/background.dart'; // Import for Background

class AssessmentQuizzesPage extends StatefulWidget {
  const AssessmentQuizzesPage({super.key});

  @override
  _AssessmentQuizzesPageState createState() => _AssessmentQuizzesPageState();
}

class _AssessmentQuizzesPageState extends State<AssessmentQuizzesPage> {
  Color passagesColor = Colors.white; // Color for Passages
  Color quizzesColor = Colors.yellow; // Color for Quizzes

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
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
                      builder: (context) => const AssessmentPage(),
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
                        builder: (context) => const AssessmentPage(),
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
        body: Column(
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
                        builder: (context) => const CreateQuizScreen(storyId: 'sample_story_id'), // Sample story ID
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between the button and the quizzes
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
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
                      var data = quiz.data() as Map<String, dynamic>?; // Safely cast to Map
                      var title = data != null && data.containsKey('title') ? data['title'] : 'No Title'; // Handle missing title field
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
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.green, // Background color for the quiz item
                              borderRadius: BorderRadius.circular(20.0), // Rounded corners
                            ),
                            child: Center(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white, // Text color
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
