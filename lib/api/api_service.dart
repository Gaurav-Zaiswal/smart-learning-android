import 'dart:io';
import "dart:convert";

import 'package:http/http.dart' as http;
// import 'package:scoreapp/models/assignment_creation_model.dart';
// import 'package:scoreapp/models/assignment_list_view_model.dart';
// import 'package:scoreapp/models/assignment_submission_model.dart';
// import 'package:scoreapp/models/classroon_join_model.dart';
// import 'package:scoreapp/models/create_feed_model.dart';
// import 'package:scoreapp/models/create_classroom_model.dart';
// import 'package:scoreapp/models/feed_list_model.dart';
// import 'package:scoreapp/models/home_screen_model.dart';

import 'package:aithon/model/login_model.dart';
// import 'package:scoreapp/model/register_student_model.dart';
// import 'package:scoreapp/model/register_teacher_model.dart';
// import 'package:scoreapp/model/submitted_assignment_list_model.dart';
import 'package:aithon/model/user_model.dart';
// import 'package:scoreapp/screens/create_assignment_t.dart';
// import 'package:scoreapp/utils/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    //endpoint to let users login

    // String url = "https://reqres.in/api/login/";
    String url = "https://gauravjaiswal.pythonanywhere.com/users/api/login/";
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      // Map<String, dynamic> logInResponse = json.decode(response.body);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the Data!');
    }
  }


  Future setUserDetails(String token) async {
    // this method is used to store basic userdetaied on a local storage
    // so that we do not have to call API everytime we need user's details
    // returns boolean True if user's info was successfully written on shared preferences
    try {
      final r = await http.get(
        Uri.parse(
            'https://gauravjaiswal.pythonanywhere.com/users/api/user-info'),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader: 'token ${token}',
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
}
// 