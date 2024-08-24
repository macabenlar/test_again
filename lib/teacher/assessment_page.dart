import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/story_list_widget.dart';
import 'package:test_again/teacher/story_detail_page.dart';
import 'package:test_again/widgets/background.dart'; // Import the Background widget
import 'package:test_again/screens/create_story_page.dart'; // Import CreateStoryPage
import 'assessment_quizzes.dart';
import 'package:test_again/widgets/assign_story_quiz_page.dart'; // Import the AssignStoryQuizPage
import 'package:test_again/widgets/add_button.dart'; // Import the CustomAddButton

class AssessmentPage extends StatefulWidget { 
  const AssessmentPage({super.key});

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  Color passagesColor = Colors.yellow;
  Color quizzesColor = Colors.white;

  void navigateToStoryDetail(String docId, String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailPage(docId: docId, title: title, content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background( // Background widget as a wrapper for all content
        child: Scaffold(
          backgroundColor: Color.fromARGB(0, 110, 13, 13), // Make Scaffold transparent
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF15A323),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Passages',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: passagesColor,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssessmentQuizzesPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Quizzes',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: quizzesColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: StoryListWidget(
                  onTapStory: (docId, title, content) {
                    navigateToStoryDetail(docId, title, content);
                  },
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssignStoryQuizPage(),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.assignment_ind),
                ),
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: CustomAddButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateStoryPage(),
                      ),
                    );
                  },
                  titleController: TextEditingController(), // Not used in this case, can be null
                  contentController: TextEditingController(), // Not used in this case, can be null
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
