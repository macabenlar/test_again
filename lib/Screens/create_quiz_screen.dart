import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateQuizScreen extends StatefulWidget {
  final String storyId;

  const CreateQuizScreen({Key? key, required this.storyId}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _quizTitleController = TextEditingController();
  final List<TextEditingController> _questionControllers = [];
  final List<List<TextEditingController>> _optionControllers = [];
  final List<TextEditingController> _correctAnswerControllers = [];

  void _addQuestion() {
    setState(() {
      _questionControllers.add(TextEditingController());
      _optionControllers.add(List.generate(4, (index) => TextEditingController()));
      _correctAnswerControllers.add(TextEditingController());
    });
  }

  Future<void> _saveQuiz() async {
    final quizTitle = _quizTitleController.text;
    final questions = _questionControllers.map((controller) => controller.text).toList();
    final options = _optionControllers.map((controllers) => controllers.map((controller) => controller.text).toList()).toList();
    final correctAnswers = _correctAnswerControllers.map((controller) => controller.text).toList();

    final questionData = [];
    for (int i = 0; i < questions.length; i++) {
      questionData.add({
        'question': questions[i],
        'options': {
          'A': options[i][0],
          'B': options[i][1],
          'C': options[i][2],
          'D': options[i][3],
        },
        'correctAnswer': correctAnswers[i],
      });
    }

    final quizData = {
      'title': quizTitle,
      'storyId': widget.storyId,
      'questions': questionData,
    };

    await FirebaseFirestore.instance.collection('Quizzes').add(quizData);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _quizTitleController,
                decoration: const InputDecoration(labelText: 'Quiz Title'),
              ),
              ..._questionControllers.asMap().entries.map((entry) {
                final index = entry.key;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(labelText: 'Question ${index + 1}'),
                    ),
                    ..._optionControllers[index].asMap().entries.map((optEntry) {
                      final optIndex = optEntry.key;
                      return TextFormField(
                        controller: optEntry.value,
                        decoration: InputDecoration(labelText: 'Option ${['A', 'B', 'C', 'D'][optIndex]}'),
                      );
                    }).toList(),
                    TextFormField(
                      controller: _correctAnswerControllers[index],
                      decoration: const InputDecoration(labelText: 'Correct Answer'),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveQuiz,
                child: const Text('Save Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
