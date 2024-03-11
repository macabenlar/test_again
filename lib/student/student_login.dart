// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'student_sign_up.dart';
import 'student_home_page.dart';

final _formKey = GlobalKey<FormState>();

class LogInStudent extends StatefulWidget {
  const LogInStudent({super.key});

  @override
  State<LogInStudent> createState() => _LogInStudentState();
}

class _LogInStudentState extends State<LogInStudent> {
  // ignore: non_constant_identifier_names
  final TextEditingController _IDnum = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_sharp),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  bottom: 50,
                ),
                height: 50,
                child: const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _IDnum,
                validator: (idnum) =>
                    idnum!.length > 3 ? "Please put atleast 8 numbers" : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers),
                  labelText: "ID Number",
                  hintText: "Please Enter Your ID",
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
                validator: (pwd) => pwd!.length > 5 ? "heelow" : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                  labelText: "Password",
                  hintText: "Please Enter Your password",
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const StudentHomePage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Log In as Student",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
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


