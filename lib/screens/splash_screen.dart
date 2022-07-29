import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aithon/utils/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final UserSecureStorage userSecureStorage = UserSecureStorage();
  late bool isTeacher, isStudent;
  @override
  void initState() {
    super.initState();
    // _navigateToHomeOrLogin();
    navigateToLogin(); // this is temporary

  }

  // _navigateToHomeOrLogin() async {
  //   final String? token = await UserSecureStorage.getUserToken();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isTeacher = prefs.getBool("isTeacher");
  //   isStudent = prefs.getBool("isStudent")!;
  //   await Future.delayed(
  //     const Duration(milliseconds: 2000),
  //     () {
  //       // token == null ? Get.offNamed("/login") : Get.offNamed("/home-student");
  //       token == null ? Get.offNamed("/login") : directTOHome();
  //     },
  //   );
  // }

  navigateToLogin() async {
    // this is temporary
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {
           Get.offNamed('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Aithon',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  directTOHome() {
    if (isStudent) {
      Get.offNamed("/home-student");
    } else if (isTeacher) {
      Get.offNamed("/home-teacher");
    } else {
      Get.offNamed("/login");
    }
  }
}
