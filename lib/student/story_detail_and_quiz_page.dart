import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_page.dart';

class StoryDetailAndQuizPage extends StatelessWidget {
  final String storyId;
  final String quizId;

  const StoryDetailAndQuizPage({
    Key? key,
    required this.storyId,
    required this.quizId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STORY',
          style: TextStyle(
            color: Colors.white, // Set the text color to white
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        centerTitle: true, // Center the title text
        automaticallyImplyLeading: false, // Remove the back button
        backgroundColor: const Color(0xFF15A323),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Stories').doc(storyId).get(),
        builder: (context, storySnapshot) {
          if (!storySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var storyData = storySnapshot.data;
          var storyTitle = storyData?['title'] ?? 'No Title';
          var storyContent = storyData?['content'] ?? 'No Content';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment: CrossAxisAlignment.center, // Center the content
              children: [
                const SizedBox(height: 30), // Add space above the title
                Text(
                  storyTitle,
                  textAlign: TextAlign.center, // Center the text
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 20), // Add space between title and content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0), // Add space at the top of the content
                      child: Text(
                        storyContent,
                        textAlign: TextAlign.center, // Center the text
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter, // Align the button at the bottom
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(quizId: quizId),
                        ),
                      );
                    },
                    child: const Text('Start Quiz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15A323), // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
