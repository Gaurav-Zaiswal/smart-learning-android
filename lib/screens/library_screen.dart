import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({ Key? key }) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext contexta) {
    return Scaffold(
      appBar: AppBar(title: Text("Library")),
      body: const Center(
        child: Text("This is Library Screen"),
      ),
    );
  }
}