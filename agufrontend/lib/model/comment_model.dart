import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
  int id;
  String text;
  String createdTime;
  int userId;
  String userName;

  CommentModel({
    required this.id,
    required this.text,
    required this.createdTime,
    required this.userId,
    required this.userName,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      id: json["id"],
      text: json["text"],
      createdTime: json["createdTime"],
      userId: json["user"]["id"],
      userName: json["user"]["userName"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "createdTime": createdTime,
        "userId": userId,
        "userName": userName,
      };
}
