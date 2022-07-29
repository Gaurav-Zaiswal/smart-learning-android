import 'package:aithon/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:aithon/screens/loginscreen.dart';


void main() {
  runApp(const Aithon());
}

class Aithon extends StatelessWidget {
  const Aithon({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Learning System',
      initialRoute:'/splash', 
      //When using initialRoute, don’t define a home property.
      // all id are classroomid unless specified seperetely
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
        // GetPage(name: "/home-teacher", page: () => HomeScreen()), // permananet path for home page techer
        // GetPage(name: "/home-student", page: () => HomeScreenStudent()),
        // GetPage(name: "/register-teacher", page: () => TeacherRegistration()),
        // GetPage(name: "/register-student", page: () => StudentRegistration()),
        GetPage(name: "/login", page: () => const LoginScreen()),
        GetPage(name: "/logout", page: () => const LoginScreen()),

        // GetPage(name: "/create-class", page: () => CreateClass()),
        // GetPage(name: "/create-class", page: () => CreateClassroom()),
        // GetPage(name: "/view-class-teacher/:id", page: () => ClassDetailsTeacher()),
        // GetPage(name: "/view-class-student/:id", page: () => ClassDetailsStudent()),
        // GetPage(name: "/classroom", page: () => VideoConferenceScreen()),
        // GetPage(name: "/create-assignemnt", page: () => LoginScreen()),
        // GetPage(name: "/list-assignment/:id", page: () => AssignmentListStudent()),
        // GetPage(name: "/submitted-assignment/:id", page: () => SubmittedAssignments())
      ]

    );
  }
}
