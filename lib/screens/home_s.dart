import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aithon/api/api_service.dart';
import 'package:aithon/controller/classroom_controller.dart';
import 'package:aithon/utils/main_drawer_s.dart';
// import 'dart:ui' as ui;
// import 'package:aithon/utils/HeaderFooter.dart';
import 'package:aithon/widgets/class_widget_s.dart';
import 'package:aithon/screens/library_screen.dart';
import 'package:aithon/screens/forum_screen.dart';
import 'package:aithon/screens/homescreen_s.dart';
import 'package:aithon/screens/search_screen.dart';

import 'package:aithon/widgets/bootomsheet_widget_s.dart';

// homepage for student
// it will render homescreen_s screen by default
class HomeStudent extends StatefulWidget {
  const HomeStudent({Key? key}) : super(key: key);

  // final String username;
  // const HomeScreen(this.username);

  @override
  HomeStudentState createState() => HomeStudentState();
}

class HomeStudentState extends State<HomeStudent> {
  List classroomList = [];

  // final ClassroomController classroomController =
  //     Get.put(ClassroomController());

  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreenStudent(),
    const Library(), 
    const Forum(), 
    const Search()
  ];
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentScreen = const HomeScreenStudent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Class Joined'),
      // ),
      drawer: MainDrawerStudent(),
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currentScreen,
      ),
      floatingActionButton: const MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left side of the add button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomeScreenStudent();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 30,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Library();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books_rounded,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Library',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen = const Forum();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.groups,
                        color: currentTab == 2 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Forum',
                        style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen = const Search();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: currentTab == 3 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey),
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
