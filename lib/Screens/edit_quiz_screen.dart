import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/background.dart'; // Import the Background widget

class EditQuizScreen extends StatefulWidget {
  final String quizId;

  const EditQuizScreen({super.key, required this.quizId});

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final TextEditingController _quizTitleController = TextEditingController();
  final List<TextEditingController> _questionControllers = [];
  final List<List<TextEditingController>> _optionControllers = [];
  final List<TextEditingController> _correctAnswerControllers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    try {
      var quizDoc = await FirebaseFirestore.instance.collection('Quizzes').doc(widget.quizId).get();
      if (quizDoc.exists) {
        var quizData = quizDoc.data()!;

        _quizTitleController.text = quizData['title'];

        for (var question in quizData['questions']) {
          var questionController = TextEditingController(text: question['question']);
          var optionControllers = [
            TextEditingController(text: question['options']['A']),
            TextEditingController(text: question['options']['B']),
            TextEditingController(text: question['options']['C']),
            TextEditingController(text: question['options']['D']),
          ];
          var correctAnswerController = TextEditingController(text: question['correctAnswer']);

          _questionControllers.add(questionController);
          _optionControllers.add(optionControllers);
          _correctAnswerControllers.add(correctAnswerController);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quiz not found')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load quiz: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      'questions': questionData,
    };

    await FirebaseFirestore.instance.collection('Quizzes').doc(widget.quizId).update(quizData);

    Navigator.pop(context);
  }

  Future<void> _deleteQuiz() async {
    await FirebaseFirestore.instance.collection('Quizzes').doc(widget.quizId).delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Quiz'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteQuiz,
          ),
        ],
      ),
      body: Background( // Wrap the entire body with the Background widget
        child: Padding(
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
                      }),
                      TextFormField(
                        controller: _correctAnswerControllers[index],
                        decoration: const InputDecoration(labelText: 'Correct Answer'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
                ElevatedButton(
                  onPressed: _addQuestion,
                  child: const Text('Add Question'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveQuiz,
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
