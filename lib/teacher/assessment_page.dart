import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/story_list_widget.dart';
import 'package:test_again/teacher/story_detail_page.dart';
import 'package:test_again/widgets/add_button.dart';
import 'assessment_quizzes.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({Key? key}) : super(key: key);

  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  Color passagesColor = Colors.yellow;
  Color quizzesColor = Colors.white;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isAddingStory = false;

  void addStory() {
    FirebaseFirestore.instance.collection('stories').add({
      'title': titleController.text,
      'body': bodyController.text,
    }).then((value) {
      String docId = value.id;
      titleController.clear();
      bodyController.clear();
      setState(() {
        isAddingStory = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added Story Successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      navigateToStoryDetail(docId, titleController.text, bodyController.text);
    }).catchError((error) {
      print('Error adding story: $error');
    });
  }

  void navigateToStoryDetail(String docId, String title, String body) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryDetailPage(docId: docId, title: title, body: body),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF15A323),
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
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
          Positioned.fill(
            top: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: StoryListWidget(
                  onTapStory: (title, body) {
                  navigateToStoryDetail('', title, body);
                  },

                ),
              ),
            ),
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            child: CustomAddButton(
              onPressed: () {
                setState(() {
                  isAddingStory = true;
                });
              },
              titleController: titleController,
              bodyController: bodyController,
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
