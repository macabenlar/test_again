import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_again/widgets/background.dart'; // Import the Background widget

class SignUpStudent extends StatefulWidget {
  const SignUpStudent({super.key});

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedGradeLevel;
  String? _selectedGender;
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    bool isFieldsNotEmpty = _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty &&
                            _firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _selectedGradeLevel != null &&
                            _selectedGender != null &&
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
      // Check if email is already in use
      final existingUser = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: _emailController.text)
          .get();
      
      if (existingUser.docs.isNotEmpty) {
        setState(() {
          _errorMessage = 'Email is already in use';
        });
        return; // Do not proceed if email is already in use
      }
      
      // Create user
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get the user UID
      String uid = userCredential.user!.uid;

      // Store user information in Firestore under 'Users' collection
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'role': 'student',
        'email': _emailController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'gradeLevel': _selectedGradeLevel,
        'gender': _selectedGender,
      });

      // Store user information in Firestore under 'Students' collection
      await FirebaseFirestore.instance.collection('Students').doc(uid).set({
        'uid': uid,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'gradeLevel': _selectedGradeLevel,
        'gender': _selectedGender,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully registered!')),
      );

      Navigator.pop(context); // Go back to the previous screen
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign up failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allow the screen to resize when the keyboard appears
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
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
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "First Name",
                  hintText: "Please Enter Your First Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _firstNameController.text.isEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Last Name",
                  hintText: "Please Enter Your Last Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _lastNameController.text.isEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Email Address",
                  hintText: "Please Enter Your Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _emailController.text.isEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  labelText: "Password",
                  hintText: "Please Enter Your Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _passwordController.text.isEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                  labelText: "Confirm Password",
                  hintText: "Please Confirm Your Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _confirmPasswordController.text.isEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGradeLevel,
                hint: const Text('Select Grade Level'),
                items: ['1', '2', '3', '4', '5', '6', '7'].map((grade) {
                  return DropdownMenuItem(
                    value: grade,
                    child: Text('Grade $grade'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGradeLevel = value;
                  });
                  _validateInputs(); // Validate inputs when grade level is selected
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _selectedGradeLevel == null ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                hint: const Text('Select Gender'),
                items: ['Male', 'Female'].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                  _validateInputs(); // Validate inputs when gender is selected
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _selectedGender == null ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _errorMessage != null
                  ? Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonDisabled ? null : signUp,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      return _isButtonDisabled ? Colors.grey : Colors.green;
                    },
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                
                  )
                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
