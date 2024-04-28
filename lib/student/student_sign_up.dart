import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({Key? key}) : super(key: key);

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _gradeLevelController = TextEditingController();
  bool _isButtonDisabled = true;
  String? _errorMessage;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _confirmPasswordController.addListener(_validateInputs);
    _firstNameController.addListener(_validateInputs);
    _lastNameController.addListener(_validateInputs);
    _gradeLevelController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeLevelController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    // Update your validation logic to include firstname, lastname, and grade level
    bool isFieldsNotEmpty = _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty &&
                            _firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _gradeLevelController.text.isNotEmpty &&
                            _passwordController.text == _confirmPasswordController.text &&
                            _passwordController.text.length >= 6;

    setState(() {
      _isButtonDisabled = !isFieldsNotEmpty;
      _errorMessage = isFieldsNotEmpty ? null : 'Please fill in all fields correctly';
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
        email: _emailController.text,
        password: _passwordController.text,
      );
      
      // Add user details to Firestore
      await FirebaseFirestore.instance.collection('Students').doc(userCredential.user!.uid).set({
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'gradeLevel': _gradeLevelController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
        'email': _emailController.text,
        'role': 'student',
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration successful! Welcome ${_firstNameController.text}'),
      ));
      Navigator.pop(context); // Navigate back to the login page
    } catch (e) {
      // Handle errors in sign up
      String errorMessage = 'Registration failed. Please try again.';
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use. Please use a different email.';
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
        child: SingleChildScrollView( // Changed to SingleChildScrollView to prevent overflow when keyboard appears
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100), // Increased space at the top to push everything lower
              const Text(
                "Student Registration Page",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
             
             ),
            // TextFields for first name, last name, and grade level
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter Your First Name",
                ),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter Your Last Name",
                ),
              ),
              TextFormField(
                controller: _gradeLevelController,
                decoration: const InputDecoration(
                  labelText: "Grade Level",
                  hintText: "Enter Your Grade Level",
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter Your Email Address",
                ),
              ),
              TextFormField(
                controller: _passwordController,
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
                controller: _confirmPasswordController,
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
