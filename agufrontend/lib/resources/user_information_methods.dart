import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';
import 'auth_methods.dart';

class UserInfoMethods {
  static UserModel user = UserModel(
    id: 0,
    userName: '',
    password: '',
    email: '',
    isActive: 0,
    // createdTime: DateTime.now(),
    // avatar: null,
    backgroundImage: '',
    bioContent: '',
    birthdate: DateTime.now(),
    nameSurname: '',
    userRole: '',
  );

  Future<UserModel> getUserById() async {
    int userId = int.parse(AuthMethods.userId);

    final response = await http.get(
      Uri.parse('http://localhost:9090/api/v1/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final jsonBody = json.decode(response.body);
    user.id = jsonBody['id'];
    user.userName = jsonBody['userName'];
    user.email = jsonBody['email'];
    user.isActive = jsonBody['isActive'];
    //user.createdTime = jsonBody['createdTime'] as DateTime;
    //user.avatar = jsonBody['avatar'];
    user.backgroundImage = jsonBody['backgroundImage'];
    user.bioContent = jsonBody['bioContent'];
    user.birthdate = jsonBody['birthdate'];
    user.nameSurname = jsonBody['nameSurname'];
    user.userRole = jsonBody['userRole'];
    return user;
  }
}
