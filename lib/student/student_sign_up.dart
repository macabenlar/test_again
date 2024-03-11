import 'package:flutter/material.dart';

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({super.key});

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _mname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _cpwd = TextEditingController();
  int _value = 1;

  @override
  void dispose() {
    _id.dispose();
    _fname.dispose();
    _mname.dispose();
    _lname.dispose();
    _pwd.dispose();
    _cpwd.dispose();
    //to dispose all controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_sharp),
              ),
              const Text(
                "Student Registration Page",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _id,
                validator: (id) =>
                    id!.length > 7 ? "Please put atleast 8 numbers" : null,
                decoration: const InputDecoration(
                  labelText: "ID Number",
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
                      keyboardType: TextInputType.name,
                      controller: _fname,
                      validator: (fname) =>
                          fname!.isNotEmpty ? "Please put your name" : null,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _mname,
                      validator: (mname) => mname!.isNotEmpty
                          ? "Please put your middle name"
                          : null,
                      decoration: const InputDecoration(
                        labelText: "Middle Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _lname,
                      validator: (lname) => lname!.isNotEmpty
                          ? "Please put your last name"
                          : null,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
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
                keyboardType: TextInputType.number,
                controller: _pwd,
                validator: (pwd) =>
                    pwd!.length > 3 ? "Please put atleast 8 numbers" : null,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Please Enter Your Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _fname,
                validator: (fname) =>
                    fname!.isNotEmpty ? "Please enter your name" : null,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Please Confirm your password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {},
                child: const Center(
                  heightFactor: 2,
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                      "Sign In Now!",
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
