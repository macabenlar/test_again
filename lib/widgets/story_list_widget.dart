import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryListWidget extends StatelessWidget {
  final Function(String, String, String) onTapStory;

  const StoryListWidget({Key? key, required this.onTapStory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set a consistent background color
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Stories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final stories = snapshot.data!.docs;
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              final docId = story.id; // Get the document ID
              final title = story['title'];
              final content = story['content'];
              return GestureDetector(
                onTap: () => onTapStory(docId, title, content),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
