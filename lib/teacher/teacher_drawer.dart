import 'package:flutter/material.dart';

class TeacherDrawer extends StatefulWidget {
  const TeacherDrawer({super.key});

  @override
  State<TeacherDrawer> createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(
                    30,
                  ),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 80,
                    foregroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                    ),
                    child: Text(
                      "Angelou Cantere Lapad",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "Teacher",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(leading: const Icon(Icons.home_filled),title: const Text("Home"),onTap: () {
            Navigator.pop(context);
          },),
          ListTile(leading: const Icon(Icons.person),title: const Text("Profile"),onTap: () {
            Navigator.pop(context);
          },),
          ListTile(leading: const Icon(Icons.note_add),title: const Text("Assessments"),onTap: () {
            Navigator.pop(context);
          },),
          ListTile(leading: const Icon(Icons.computer),title: const Text("Students"),onTap: () {
            Navigator.pop(context);
          },),
          const SizedBox(
            height: 170,
          ),
          const Divider(thickness: 1, color: Colors.black,),
          ListTile(leading: const Icon(Icons.logout),title: const Text("Log Out"),onTap: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },),
        ],
      ),
    );
  }
}
