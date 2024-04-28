import 'package:flutter/material.dart';
import 'student_sign_up.dart';
import 'student_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LogInStudent extends StatefulWidget {
  const LogInStudent({Key? key}) : super(key: key);

  @override
  State<LogInStudent> createState() => _LogInStudentState();
}

class _LogInStudentState extends State<LogInStudent> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  bool _obscureText = true; // Variable to toggle password visibility

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _pwd.text,
        );
        // Check role from Firestore
        var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get();
        if (userDoc.exists && userDoc.data()!['role'] == 'student') {
          // Navigate to StudentHomePage on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentHomePage(),
            ),
          );
        } else {
          // Not a student
          throw Exception('Not authorized as student');
        }
      } catch (e) {
        // Handle login errors
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: Text(e is FirebaseAuthException ? e.message! : 'Invalid email or password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent the screen from resizing when the keyboard appears
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  bottom: 50,
                ),
                height: 50,
                child: const Text(
                  "Welcome Back, Student!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (email) => email!.isNotEmpty ? null : 'Please enter your email',
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email Address",
                  hintText: "Please Enter Your Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: _pwd,
                obscureText: _obscureText, // Toggle password visibility
                validator: (pwd) => pwd!.length >= 6 ? null : 'Password must be at least 6 characters',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility), // Change icon based on _obscureText value
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Toggle password visibility
                      });
                    },
                  ),
                  labelText: "Password",
                  hintText: "Please Enter Your Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  // Handle forgot password
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Form(
                          child: Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                hintText: "Enter Your Email",
                                label: Text(
                                  "Email",
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Send!"),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  "Forgot Password?",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 55,
                width: 500,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _login,
                  child: const Text(
                    "Log In as Student",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                            return const SignUpStudent();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up Now!",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
