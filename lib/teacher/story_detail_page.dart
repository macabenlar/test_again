import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/edit_delete_update_buttons.dart'; // Import the EditDeleteUpdateButtons widget

class StoryDetailPage extends StatefulWidget {
  final String docId;
  final String title;
  final String body;

  const StoryDetailPage({
    super.key,
    required this.docId,
    required this.title,
    required this.body,
  });

  @override
  _StoryDetailPageState createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    bodyController = TextEditingController(text: widget.body);
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  Future<void> updateStory() async {
    try {
      if (widget.docId.isNotEmpty) { // Check if docId is not empty
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('stories').doc(widget.docId).get();
        if (snapshot.exists) {
          print('Document exists, proceeding with update...');
          await FirebaseFirestore.instance.collection('stories').doc(widget.docId).update({
            'title': titleController.text,
            'body': bodyController.text,
          });
          print('Update successful');
          setState(() {
            isEditing = false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Story updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Document does not exist')),
          );
        }
      } else {
        print('Document ID is empty');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Document ID is empty')),
        );
      }
    } catch (e) {
      print('Firestore Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update story: $e')),
      );
    }
  }

  void deleteStory() {
    // Implement delete logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story'), // Empty title
        centerTitle: true, // Center align the title in the AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          isEditing
              ? TextFormField(
                  controller: titleController,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  textAlign: TextAlign.center,
                )
              : Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: 100), // Adjust height as needed
          isEditing
              ? TextFormField(
                  controller: bodyController,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                )
              : Text(
                  widget.body,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: 32),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(55.0),
                child: EditDeleteUpdateButtons(
                  onEditPressed: () {
                    setState(() {
                      isEditing = true;
                    });
                  },
                  onDeletePressed: () {
                    // Implement delete logic here
                  },
                  onUpdatePressed: () {
                    updateStory(); // Call the update function here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}