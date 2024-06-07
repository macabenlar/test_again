import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:test_again/sign_up_page.dart';
import 'package:test_again/student/student_login.dart';
import 'package:test_again/teacher/teacher_login.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 1.0,
            ),
            const Text(
              "Welcome Onboard!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/Teacher.png"),
                Container(
                  height: 50,
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Color(0xFF15A323),
                    borderRadius: BorderRadius.all(
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
                            return const LogInTeacher();
                          },
                        ),
                      );
                    },
                    child: const Text("Log In as a Teacher", style: TextStyle(color: Colors.white, fontSize: 18,
                      fontWeight: FontWeight.bold,)
                  ),
                ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "OR",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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
                  decoration: const BoxDecoration(
                    color: Color(0xFF15A323),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LogInStudent();
                          },
                        ),
                      );
                    },
                    child: const Text(
                    "Log in as a Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUp();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up!",
                     style: TextStyle(
                    color: Color(0xFF15A323),
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}