import 'dart:convert';

import 'package:agufrontend/model/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentMethods {
  static List<CommentModel> comments = [
    CommentModel(
        id: 1,
        text: "null comment text",
        createdTime: "null cttime",
        userId: -1,
        userName: 'null comment username')
  ];

  Future<List<CommentModel>> getAllCommentsByPostId(int postId) async {
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/v1/comment?postId=$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    comments = commentModelFromJson(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<CommentModel> comments =
          jsonResponse.map((data) => CommentModel.fromJson(data)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
