import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpTeacher extends StatefulWidget {
  const SignUpTeacher({Key? key}) : super(key: key);

  @override
  State<SignUpTeacher> createState() => _SignUpTeacherState();
}

class _SignUpTeacherState extends State<SignUpTeacher> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _isButtonDisabled = true;
  String? _errorMessage;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _email.addListener(_validateInputs);
    _password.addListener(_validateInputs);
    _confirmPassword.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _validateInputs() {
    setState(() {
      if (_email.text.isNotEmpty &&
          _password.text.isNotEmpty &&
          _confirmPassword.text.isNotEmpty &&
          _password.text == _confirmPassword.text &&
          _password.text.length >= 6) {
        _isButtonDisabled = false;
        _errorMessage = null;
      } else {
        _isButtonDisabled = true;
        if (_password.text != _confirmPassword.text) {
          _errorMessage = 'Passwords do not match';
        } else {
          _errorMessage = 'Please fill in all fields and ensure the password is at least 6 characters long.';
        }
      }
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  Future<void> signUp() async {
    if (_isButtonDisabled) {
      return; // Do not proceed with signup if button is disabled
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // Handle successful signup, show a success message, and navigate to the login page
      print('User signed up: ${userCredential.user?.email}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration successful!'),
      ));
      Navigator.pop(context); // Navigate back to the login page
    } catch (e) {
      // Handle signup errors
      print('Signup Error: $e');
      String errorMessage = 'Registration failed. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'The email address is already in use. Please use a different email.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
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
                const Text(
                  "Teacher Registration Page",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    hintText: "Enter Your Email Address",
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Your Password",
                    suffixIcon: IconButton(
                      icon: _showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: !_showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Confirm Your Password",
                    suffixIcon: IconButton(
                      icon: _showConfirmPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _isButtonDisabled ? null : signUp,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
