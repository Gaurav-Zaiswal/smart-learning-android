import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:aithon/api/api_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aithon/model/login_model.dart';
import 'package:aithon/utils/secure_storage.dart';
// import 'homescreen_t.dart';

//setting up some global variables
TextStyle primary = const TextStyle(fontSize: 25);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late String username;
  late String password;

  APIService apiService = APIService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;

  late LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                        key: globalFormKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 150,
                            ),
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                            //emailfield
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => requestModel.email = input,
                              validator: (input) => !input!.contains("@")
                                  ? "Invalid Email"
                                  : null,
                              decoration: const InputDecoration(
                                hintText: "Email Address",
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),

                            // password field
                            TextFormField(
                              keyboardType: TextInputType.text,
                              // onSaved: ,
                              obscureText: hidePassword,
                              onSaved: (input) => requestModel.password = input,
                              validator: (input) => input!.length < 5
                                  ? "Password must be at least 5 characters long"
                                  : null,

                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    icon: Icon(hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // login button using material
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lightGreen,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context)
                                    .size
                                    .width, //sets minimum width as of size of screen
                                padding: const EdgeInsets.all(20),
                                onPressed: () {
                                  // call the ogin api if credential is valid
                                  if (validateAndSave()) {
                                    apiService
                                        .login(requestModel)
                                        .then((value) {
                                      if (value.token.isNotEmpty) {
                                        // save the token to flutter secure storage
                                        UserSecureStorage.setUserToken(
                                            value.token);
                                        // send user to specific home page based on role
                                        return directToHome();
                                        // const SnackBar(
                                        //   content: Text("login successfull"),
                                        // );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Check your email and password and try again."),
                                        ));
                                      }
                                    });
                                  } else {
                                    // throw Exception("Validation Failed.");
                                  }
                                },
                                child: const Text("Log in"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                const Text("New User?"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // register as teacher button
                                    TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        // Get.offAllNamed("/register-teacher");
                                      },
                                      child: const Text('Register as teacher'),
                                    ),

                                    // register as student button
                                    TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        Get.offAllNamed("/register-student");
                                      },
                                      child: const Text('Register as student'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void directToHome() async {
    String? token = await UserSecureStorage.getUserToken();
    // set user details such as isTeacher flag on shared preference
    final isSuccess = await apiService.setUserDetails(token);

    if (isSuccess == true) {
      // if the setUserDetails returns true then check is the user is teacher/student
      // and redirect them accordingly
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isTeacher = prefs.getBool('isTeacher');
      final bool? isStudent = prefs.getBool('isStudent');
      // if (prefs.getBool('isTeacher') && !prefs.getBool('isStudent')) {
      //   Get.offAllNamed("/home-teacher");
      // } else if (prefs.getBool('isStudent') && !prefs.getBool('isTeacher')) {
      //   Get.offAllNamed("/home-student");
      // }
      if (isTeacher == true && isStudent == false) {
        Get.offAllNamed("/home-teacher");
      } else if (isStudent == true && isTeacher==false) {
        Get.offAllNamed("/home-student");
      }
      const SnackBar(content: Text("login successful!"));
    } else {
      const sb = SnackBar(
        content: Text("Something went wrong while loggin in!"),
      );
      // if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(sb);
      // throw Exception('field value cannot be null.');
    }
  }
}
