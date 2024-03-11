import 'package:flutter/material.dart';
import 'package:test_again/student/student_sign_up.dart';
import 'package:test_again/teacher/teacher_sign_up_.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
            ),
          ),
          const Text(
            "Welcome Onboard!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/Teacher.png"),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: TextButton(
                  style: const ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpTeacher();
                        },
                      ),
                    );
                  },
                  child: const Text("Sign Up as a Teacher"),
                ),
              ),
            ],
          ),
          const Text(
            "OR",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  "assets/images/Person.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpStudent();
                        },
                      ),
                    );
                  },
                  child: const Text("Sign Up as a Student"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Sign In!",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
