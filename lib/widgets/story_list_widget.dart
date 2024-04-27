import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryListWidget extends StatelessWidget {
  final Function(String title, String body) onTapStory; // Define onTapStory here

  const StoryListWidget({super.key, required this.onTapStory});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Container(
          margin: const EdgeInsets.only(top: 20.0), // Adjust the top margin as needed
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var title = snapshot.data!.docs[index]['title'];
              var body = snapshot.data!.docs[index]['body']; // Add body variable

              return GestureDetector(
                onTap: () {
                  onTapStory(title, body); // Call onTapStory function
                },
                child: Container(
                  height: 100.0, // Adjust height as needed
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjust margins as needed
                  child: Card(
                    color: const Color(0xFF15A323), // Green color
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Padding within the Card
                        child: Text(
                          title ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white, // White text color
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
