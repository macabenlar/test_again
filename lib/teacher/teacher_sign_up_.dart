import 'package:flutter/material.dart';

class SignUpTeacher extends StatefulWidget {
  const SignUpTeacher({super.key});

  @override
  State<SignUpTeacher> createState() => _SignUpTeacherState();
}

class _SignUpTeacherState extends State<SignUpTeacher> {
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _mname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _cpwd = TextEditingController();
  bool _obscure = false;
  int _value = 1;

  @override
  void dispose() {
    _id.dispose();
    _fname.dispose();
    _mname.dispose();
    _lname.dispose();
    _pwd.dispose();
    _cpwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                const Text(
                  "Teacher Registration Page",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("ID Number"),
                    hintText: "Please Enter Your ID",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("First Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Middle Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Last Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 88, 88, 88),
                      // width: 2.0,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(
                                () {
                                  _value = value!;
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            child: Text(
                              "Male",
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(
                                () {
                                  _value = value!;
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            child: Text(
                              "Female",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    label: const Text("Password"),
                    hintText: "Please Enter Your Password",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    label: const Text("Confirm Password"),
                    hintText: "Please Confirm your Password",
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure = !_obscure;
                      });
                    }, icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off,),),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: const Center(
                    heightFactor: 2,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Already have an acount?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Sign in Now!"),
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
