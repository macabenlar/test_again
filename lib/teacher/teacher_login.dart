import 'package:flutter/material.dart';
import 'teacher_sign_up.dart';
import 'teacher_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/background.dart';  // Import your Background widget

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LogInTeacher extends StatefulWidget {
  const LogInTeacher({super.key});

  @override
  State<LogInTeacher> createState() => _LogInTeacherState();
}

class _LogInTeacherState extends State<LogInTeacher> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );

        var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).get();
        if (userDoc.exists && userDoc.data()!['role'] == 'teacher') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherHomePage(teacherId: userCredential.user!.uid),
            ),
          );
        } else {
          throw Exception('Not authorized as teacher');
        }
      } catch (e) {
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
    return Background(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,  // Make the Scaffold background transparent
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  height: 50,
                  child: const Text(
                    "Welcome Back, Teacher!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  validator: (email) => email!.isNotEmpty ? null : 'Please enter your email',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email Address",
                    hintText: "Please Enter Your Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _password,
                  obscureText: _obscureText,
                  validator: (pwd) => pwd!.length >= 6 ? null : 'Password must be at least 6 characters',
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    labelText: "Password",
                    hintText: "Please Enter Your Password",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Form(
                            child: Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Your Email",
                                  label: Text("Email"),
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
                      style: TextStyle(
                      color: Color.fromARGB(255, 61, 58, 58),
                      fontWeight: FontWeight.w100,
                      ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 55,
                  width: 500,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15A323),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      "Log In as Teacher",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                              return const SignUpTeacher();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up Now!",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
