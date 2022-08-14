import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:aithon/api/api_service.dart';  // for production
import 'package:aithon/api/api_service_local.dart'; // for local 
import 'package:aithon/model/classroom_join_model.dart';
// import 'package:scoreapp/utils/secure_storage.dart';

class MyFloatingActionButton extends StatefulWidget {
  const MyFloatingActionButton({Key? key}) : super(key: key);

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  APIService apiService = APIService();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController classCodeController = TextEditingController();

  late ClassroomJoinModel requestModel;
  String temp = "";
  @override
  void initState() {
    super.initState();
    requestModel = ClassroomJoinModel();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showBottomSheet(
              context: context,
              builder: (context) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 300,
                    color: Colors.grey[400],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                            key: globalFormKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                    "Enter the code to join the classroom"),
                                const SizedBox(
                                  height: 25,
                                ),
                                // passcode field
                                TextFormField(
                                  controller: classCodeController,
                                  onSaved: (input) =>
                                      requestModel.classCode = input!,
                                  validator: (input) => input!.length != 8
                                      ? "Code must be 8 characters long."
                                      : "",
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.vpn_key)),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                // button
                                Material(
                                  elevation: 5.0,
                                  // borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue[700],
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context)
                                            .size
                                            .width /
                                        2, //sets minimum width as of size of screen
                                    // padding: EdgeInsets.all(20),
                                    onPressed: () {
                                      // call the ogin api if credential is valid
                                      if (validateAndSave()) {
                                        apiService
                                            .joinClassroom(requestModel)
                                            .then((value) {
                                          classCodeController.clear();
                                          Get.offAllNamed("/home-student");
                                          // return directToHome();
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Some error occured while trying to join the classroom!"),
                                          dismissDirection: DismissDirection.up,
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      "Join Classroom",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ));
        });
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

  // directToHome() {
  //   Get.offAll("/home-student");
  // }
}
