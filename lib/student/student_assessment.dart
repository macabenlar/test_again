import 'package:flutter/material.dart';
import 'package:test_again/student/student_drawer.dart';
import '../constant.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../models/question_model.dart';
import '../widgets/option_card.dart';

class StudentAssessment extends StatefulWidget {
 const StudentAssessment({super.key});

 @override
 State<StudentAssessment> createState() => _StudentAssessmentState();
}

class _StudentAssessmentState extends State<StudentAssessment> {
 final List<Question> _questions = [
    Question(
      id: '10',
      title: 'What is 2 + 2?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '11',
      title: 'What is 6 + 2?',
      options: {'5': false, '30': false, '4': false, '8': true},
    ),
 ];
 
 int index = 0;
 // boolean value
 bool isPressed = false;
// next question function
 void nextQuestion() {
    if (index < _questions.length - 1) {

      if(isPressed){
      setState(() {
        index++;
        isPressed = false;
      });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Please select any option'), behavior: 
          SnackBarBehavior.floating, margin: EdgeInsets.symmetric(vertical:20.0),)
        );
      }
    }
 }

 // function for change color
 void changeColor() {
   setState(() {
     isPressed = true;
   });
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
 title: const Text('Quiz Passage', style: TextStyle(color: neutralColor)),
 backgroundColor: background,
 shadowColor: const Color.fromARGB(255, 0, 0, 0),
 leading: null, // This line removes the back icon
 automaticallyImplyLeading: false, // This line ensures the leading widget is not shown automatically
),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestions: _questions.length,
            ),
            const Divider(color: neutralColor),
            
              // add some space 
            const SizedBox(height: 25.0),
            ..._questions[index].options.entries.map((entry) {
              return OptionCard(
                option: entry.key,
                color: isPressed ? (entry.value ? Colors.green : Colors.red) : Colors.white,
                onTap: changeColor,
              );
            }).toList(),
           
          ],
        ),
      ),
      floatingActionButton: NextButton(nextQuestion: nextQuestion),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
 }
}