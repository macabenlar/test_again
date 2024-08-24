import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/background.dart'; // Import the Background widget
import 'package:test_again/widgets/edit_delete_update_buttons.dart';

class StoryDetailPage extends StatefulWidget {
  final String docId;
  final String title;
  final String content;

  const StoryDetailPage({
    super.key,
    required this.docId,
    required this.title,
    required this.content,
  });

  @override
  _StoryDetailPageState createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> updateStory() async {
    try {
      if (widget.docId.isNotEmpty) {
        await FirebaseFirestore.instance.collection('Stories').doc(widget.docId).update({
          'title': titleController.text,
          'content': contentController.text,
        });
        setState(() {
          isEditing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Story updated successfully')),
        );
      } else {
        print('Document ID is empty');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document ID is empty')),
        );
      }
    } catch (e) {
      print('Failed to update story: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update story: $e')),
      );
    }
  }

  Future<void> deleteStory() async {
    try {
      if (widget.docId.isNotEmpty) {
        await FirebaseFirestore.instance.collection('Stories').doc(widget.docId).delete();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Story deleted successfully')),
        );
      } else {
        print('Document ID is empty');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document ID is empty')),
        );
      }
    } catch (e) {
      print('Failed to delete story: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete story: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Details'),
        centerTitle: true,
      ),
      body: Background( // Wrap the entire body with the Background widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            isEditing
                ? TextFormField(
                    controller: titleController,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 20),
            isEditing
                ? TextFormField(
                    controller: contentController,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: null,
                  )
                : Text(
                    widget.content,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 32),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: EditDeleteUpdateButtons(
                    onEditPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    onDeletePressed: deleteStory,
                    onUpdatePressed: updateStory,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
