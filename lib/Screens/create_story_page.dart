import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/background.dart'; // Import the Background widget

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  _CreateStoryPageState createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addStory() {
    FirebaseFirestore.instance.collection('Stories').add({
      'title': titleController.text,
      'content': contentController.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added Story Successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);  // Go back to the previous screen after adding the story
    }).catchError((error) {
      print('Error adding story: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Story'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title TextField
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Story Title',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16.0), // Add spacing between fields

              // Content TextField
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Story Content',
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                maxLines: 6,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 24.0), // Add spacing before button

              // Add Story Button
              Center(
                child: ElevatedButton(
                  onPressed: addStory,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.green, // Text color
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Add Story',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
