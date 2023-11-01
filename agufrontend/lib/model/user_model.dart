//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  dynamic userRole;
  //dynamic avatar;
  dynamic backgroundImage;
  dynamic nameSurname;
  String userName;
  String password;
  String email;
  dynamic bioContent;
  int isActive;
  dynamic birthdate;
  //DateTime createdTime;

  UserModel({
    required this.id,
    this.userRole,
    //this.avatar,
    this.backgroundImage,
    this.nameSurname,
    required this.userName,
    required this.password,
    required this.email,
    this.bioContent,
    required this.isActive,
    this.birthdate,
    //required this.createdTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userRole: json["userRole"],
        //avatar: json["avatar"],
        backgroundImage: json["backgroundImage"],
        nameSurname: json["nameSurname"],
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
        bioContent: json["bioContent"],
        isActive: json["isActive"],
        birthdate: json["birthdate"],
        //createdTime: DateTime.parse(json["createdTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userRole": userRole,
        //"avatar": avatar,
        "backgroundImage": backgroundImage,
        "nameSurname": nameSurname,
        "userName": userName,
        "password": password,
        "email": email,
        "bioContent": bioContent,
        "isActive": isActive,
        "birthdate": birthdate,
        //"createdTime": createdTime.toIso8601String(),
      };
}
