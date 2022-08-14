/*
 * APIs for localhost
 */

import 'dart:io';
import "dart:convert";

import 'package:http/http.dart' as http;
// import 'package:scoreapp/model/assignment_creation_model.dart';
// import 'package:scoreapp/model/assignment_list_view_model.dart';
// import 'package:scoreapp/model/assignment_submission_model.dart';
import 'package:aithon/model/classroom_join_model.dart';
// import 'package:scoreapp/model/create_feed_model.dart';
// import 'package:aithon/model/create_classroom_model.dart';
import 'package:aithon/model/feed_list_model.dart';
import 'package:aithon/model/home_screen_model.dart';

import 'package:aithon/model/login_model.dart';
import 'package:aithon/model/register_student_model.dart';
// import 'package:scoreapp/model/register_teacher_model.dart';
// import 'package:scoreapp/model/submitted_assignment_list_model.dart';
import 'package:aithon/model/user_model.dart';
// import 'package:scoreapp/screens/create_assignment_t.dart';
import 'package:aithon/utils/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String domain = 'http://192.168.0.108:8000';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    //endpoint to let users login

    // String url = "https://reqres.in/api/login/";
    String url = "$domain/users/api/login/";

    // String url = "http://192.168.0.108:8000/users/api/login/";
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      // Map<String, dynamic> logInResponse = json.decode(response.body);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      print(response.toString());
      print("_________________________________________");
      throw Exception('Failed to load the Data!');
    }
  }

  Future setUserDetails(String token) async {
    // this method is used to store basic user details on a local storage
    // so that we do not have to call API everytime we need user's details
    // returns boolean True if user's info was successfully written on shared preferences
    try {
      final r = await http.get(
        Uri.parse('192.168.0.108:8000/users/api/user-info'),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader: 'token $token',
        },
      );
      if (r.statusCode == 200 || r.statusCode == 201 || r.statusCode == 400) {
        final user = UserResponseModel.fromJson(json.decode(r.body));
        // use the token to store the logged in user's detail on shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        try {
          prefs.setInt('id', user.id);
          // prefs.setString('email', user.email);
          prefs.setString('firstName', user.firstName);
          prefs.setString('lastName', user.lastName);
          prefs.setBool('isTeacher', user.isTeacher);
          prefs.setBool('isStudent', user.isStudent);
          // print("inside setUserDeatils");
          // print(prefs.getBool("isTeacher"));
          // print(prefs.getBool("isStudent"));
          // print("exiting.......");
          return true;
        } catch (e) {
          throw Exception(e);
        }
      } else {
        // print(r.statusCode);
        throw Exception("could not set the user details");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeUserDetails() async {
    // remove user's details from the local storage

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.getString('firstName');
      prefs.remove('lastName');
      prefs.remove('isTeacher');
      prefs.remove('isStudent');
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<RegisterStudentResponseModel> registerStudent(
      RegisterStudentRequestModel requestModel) async {
    // endpoint that lets any anonymous user to register as student
    // String url = "http://192.168.1.100:8000/users/api/student-register/";
    String url = "http://127.0.0.1:8000/users/api/student-register/";

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      // invalid username pwd will have 400
      // print("----------------------------------> ${response.statusCode}");
      return RegisterStudentResponseModel.fromJson(json.decode(response.body));
    } else {
      // print("----------------------------------> ${response.statusCode}");
      throw Exception('Failed to load the Data!');
    }
  }

  static Future<List<ClassListModel>> getClassrooms() async {
    // get list of enrolled classroom of either teacher or student
    // show them on homescreen

    // final storage = new FlutterSecureStorage();

    String url = "http://127.0.0.1:8000/class/api/list/";
    var token = await UserSecureStorage.getUserToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'token $token',
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      var jsonString = response.body;
      return classListModelFromJson(jsonString);
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load the Data!');
    }
  }

  Future<ClassroomJoinModel> joinClassroom(
      ClassroomJoinModel requestModel) async {
    // let studetns join the classroom via a 8 characterslong code

    String url = "http://127.0.0.1:8000/class/api/join/";
    var token = await UserSecureStorage.getUserToken();
    // print(requestModel.toJson());

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'token $token'
    };
    final body = jsonEncode(requestModel.toJson());

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      var jsonString = response.body;
      return classroomJoinModelFromJson(jsonString);
    } else if (response.statusCode == 403) {
      throw Exception(
          'forbidden: You do not have permission to join the classroom');
    } else {
      print(token);
      print("----------------------->>>>>>>>> ${response.statusCode}");
      throw Exception("Failed to join the classroom");
    }
  }

  static Future<List<ClassroomFeedListModel>> getFeeds(String classId) async {
    // get list of enrolled classroom of either teacher or student
    // show them on homescreen

    // final storage = new FlutterSecureStorage();

    String url = "http://127.0.0.1:8000/feed/api/$classId/list/";
    var token = await UserSecureStorage.getUserToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'token $token',
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      var jsonString = response.body;
      return classroomFeedListModelFromJson(jsonString);
    } else {
      // print(response.statusCode);
      throw Exception('Failed to load the Data!');
    }
  }
}
// 