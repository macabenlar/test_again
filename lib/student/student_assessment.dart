import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant.dart';
import 'story_detail_and_quiz_page.dart';

class StudentAssessment extends StatefulWidget {
  final String studentId;

  const StudentAssessment({Key? key, required this.studentId}) : super(key: key);

  @override
  State<StudentAssessment> createState() => _StudentAssessmentState();
}

class _StudentAssessmentState extends State<StudentAssessment> {
  List<DocumentSnapshot> assignedItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAssignedItems();
  }

  Future<void> loadAssignedItems() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('AssignedQuizzes')
          .where('studentId', isEqualTo: widget.studentId)
          .get();

      if (snapshot.docs.isEmpty) {
        print("No assigned quizzes found for the student.");
      } else {
        print("Assigned quizzes found: ${snapshot.docs.length}");
      }

      setState(() {
        assignedItems = snapshot.docs;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching assigned items: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Loading...', style: TextStyle(color: neutralColor)),
          centerTitle: true,
          automaticallyImplyLeading: false, // Remove the back button
          backgroundColor: Colors.green,
          shadowColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ASSIGNED PASSAGES', style: TextStyle(color: neutralColor)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the back button
        backgroundColor: Colors.green,
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20.0), // Add space at the top
        itemCount: assignedItems.length,
        itemBuilder: (context, index) {
          var item = assignedItems[index];
          var storyId = item['storyId'];
          var quizId = item['quizId'];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('Stories').doc(storyId).get(),
            builder: (context, storySnapshot) {
              if (!storySnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var storyData = storySnapshot.data;
              var storyTitle = storyData?['title'] ?? 'No Title';

              return Card(
                color: Colors.green, // Set the card color to green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // More rounded corners
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: ListTile(
                  title: Text(
                    storyTitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryDetailAndQuizPage(
                            storyId: storyId,
                            quizId: quizId,
                          ),
                        ),
                      );
                    },
                    child: const Text('Read & Quiz'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green, backgroundColor: Colors.white, // Text color
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
