import 'package:flutter/material.dart';

class StudentProfileSceen extends StatefulWidget {
  const StudentProfileSceen({ Key? key }) : super(key: key);

  @override
  State<StudentProfileSceen> createState() => _StudentProfileSceen();
}

class _StudentProfileSceen extends State<StudentProfileSceen> {
  @override
  Widget build(BuildContext contexta) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: const Center(
        child: Text("This is student profile page"),
      ),
    );
  }
}