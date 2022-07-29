class LoginResponseModel {
  final String token, error; // ? sign tells that these variable can be null

  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["token"] ?? "",
        error: json["error"] ?? ""); // new way to check null
  }
  // if token is not empty then pass json["token"] else pass nothing
}

class LoginRequestModel {
  String? email, password; 

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> credentialMap = {
      'username': email!.trim(),
      'password': password!.trim()
    };

    return credentialMap;
  }
}