import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({ Key? key }) : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreen();
}

class _RecommendationScreen extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext contexta) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses you may like!")),
      body: const Center(
        child: Text("This is the course recommendation screen for students"),
      ),
    );
  }
}