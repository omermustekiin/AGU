// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'comment_model.dart';

List<PostModel> postModelFromJson(String str, bool isSavedPost) =>
    List<PostModel>.from(
        json.decode(str).map((x) => PostModel.fromJson(x, isSavedPost)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  int id;
  String title;
  String text;
  int isPublic;
  String postedTime;
  String userName;
  CommentModel? commentModel =
      CommentModel(id: -1, text: "", createdTime: "", userId: -1, userName: '');

  PostModel({
    required this.id,
    required this.title,
    required this.text,
    required this.userName,
    this.isPublic = 1,
    this.postedTime = "",
    this.commentModel,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, isSavedPost) =>
      PostModel(
        id: isSavedPost ? json["post"]["id"] : json["id"],
        title: isSavedPost ? json["post"]["title"] : json["title"],
        text: isSavedPost ? json["post"]["text"] : json["text"],
        isPublic: isSavedPost ? json["post"]["isPublic"] : json["isPublic"],
        postedTime:
            isSavedPost ? json["post"]["postedTime"] : json["postedTime"],
        userName: isSavedPost
            ? json["post"]["user"]["userName"]
            : json["user"]["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "text": text,
        "isPublic": isPublic,
        "postedTime": postedTime,
        "userName": userName,
      };
}
