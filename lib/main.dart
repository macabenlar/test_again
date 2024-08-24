import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:test_again/Screens/log_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFECEC),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 300,
                width: 400,
                fit: BoxFit.fill,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to CISC KIDS APP!!  Iag",
                    textAlign: TextAlign.center,
                    style:  GoogleFonts.lexend(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                    
                  ),
                  SizedBox(height: 10),
                  Text(
                    " Mobile Reading Comprehension ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
               Expanded(
                 child: Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "we believe in the trans-formative power of education. Our mission is to empower learners and educators alike by providing innovative assessment solutions that foster meaningful learning experiences. We understand that assessment is not just about testing; it's about understanding, growth, and continuous improvement",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lexend(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                      ),
                    ),
                  ),
                               ),
               ),
              Expanded(
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFF15A323),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
