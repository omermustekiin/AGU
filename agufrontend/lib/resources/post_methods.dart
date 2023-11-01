import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/post_model.dart';
import 'auth_methods.dart';

class PostMethods {
  static List<PostModel> posts = [];
  static PostModel post =
      PostModel(id: 0, title: '', text: '', postedTime: '', userName: '');

  Future<dynamic> createPublicPost(
      String text, String title, String postedTime) async {
    debugPrint(postedTime.toString());
    int userId = int.parse(AuthMethods.userId);
    String output = "Alanlar Boş Bırakılamaz!";
    if (text.isNotEmpty && title.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:9090/api/v1/post/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'text': text,
            'title': title,
            'isPublic': '1',
            'postedTime': postedTime,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        output = "Success";
        debugPrint("User created public post!");
      } else {
        output = "Bugün için zaten bir günlük paylaştınız!";
      }
    }
    return output;
  }

  Future<dynamic> createPrivatePost(
      String text, String title, String postedTime) async {
    int userId = int.parse(AuthMethods.userId);
    String output = "Alanlar Boş Bırakılamaz!";
    if (text.isNotEmpty && title.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:9090/api/v1/post/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'text': text,
            'title': title,
            'isPublic': '0',
            'postedTime': postedTime,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        output = "Success";
        debugPrint("User created private post!");
      } else {
        output = "Bugün için zaten bir günlük paylaştınız!";
      }
    }
    return output;
  }

  Future<List<PostModel>> getAllPublicPosts() async {
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/v1/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    posts = postModelFromJson(response.body, false);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<PostModel> posts =
          jsonResponse.map((data) => PostModel.fromJson(data, false)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<PostModel>> getAllSavedPosts() async {
    int userId = int.parse(AuthMethods.userId);
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/v1/savedPost/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    posts = postModelFromJson(response.body, true);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<PostModel> posts =
          jsonResponse.map((data) => PostModel.fromJson(data, true)).toList();
      return posts;
    } else {
      throw Exception('Failed to load saved posts');
    }
  }

  Future<List<PostModel>> getUserPrivatePosts(int isPublic) async {
    int userId = int.parse(AuthMethods.userId);
    final response = await http.get(
      Uri.parse(
          'http://localhost:9090/api/v1/post/search?userId=$userId&isPublic=${isPublic.toString()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    posts = postModelFromJson(response.body, false);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<PostModel> posts =
          jsonResponse.map((data) => PostModel.fromJson(data, false)).toList();
      return posts;
    } else {
      throw Exception('Failed to load private posts');
    }
  }

  Future<dynamic> deletePost(int id) async {
    String output = "Başarısız!";
    final response = await http.delete(
      Uri.parse('http://localhost:9090/api/v1/post/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      output = "Success";
      debugPrint("User deleted own post!");
    } else {
      output = "Başarısız!";
    }
    return output;
  }

  Future<dynamic> deleteSavedPost(int id) async {
    String output = "Başarısız!";
    final response = await http.delete(
      Uri.parse('http://localhost:9090/api/v1/savedPost/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      output = "Success";
      debugPrint("User deleted saved post!");
    } else {
      output = "Başarısız!";
    }
    return output;
  }

  Future<dynamic> addSavedPost(String userId, String postId) async {
    String output = "Hiçbisey olmadı";
    final response = await http.post(
      Uri.parse(
          'http://localhost:9090/api/v1/savedPost?userId=$userId&postId=$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      output = "Success";
      debugPrint("User added saved post!");
    } else {
      output = "Bu gönderi zaten kayıtlı!";
    }
    return output;
  }
}
