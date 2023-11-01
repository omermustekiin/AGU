import 'package:agufrontend/resources/comment_methods.dart';
import 'package:agufrontend/resources/post_methods.dart';
import 'package:agufrontend/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../model/comment_model.dart';
import '../model/post_model.dart';
import '../widgets/navbar.dart';
import '../widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> publicPosts = [];
  List<CommentModel> comments = [];

  @override
  void initState() {
    super.initState();
    fetchPublicPosts();
    fetchComments();
  }

  Future<void> fetchPublicPosts() async {
    try {
      List<PostModel> posts = await PostMethods().getAllPublicPosts();
      setState(() {
        publicPosts = posts;
      });
    } catch (e) {
      print('Error fetching public posts: $e');
    }
  }

  Future<void> fetchComments() async {
    try {
      List<CommentModel> comments =
          await CommentMethods().getAllCommentsByPostId(PostMethods.post.id);
      setState(() {
        this.comments = comments;
      });
    } catch (e) {
      print('Error fetching comment posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: ListView.builder(
        itemCount: PostMethods.posts.length,
        itemBuilder: (BuildContext context, int index) {
          List<PostModel> sortedPosts = PostMethods.posts.reversed.toList();
          sortedPosts.sort((b, a) => a.postedTime.compareTo(b.postedTime));
          PostModel post = sortedPosts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                PostWidget(
                  title: post.title,
                  text: post.text,
                  isPublic: post.isPublic,
                  postedTime: post.postedTime,
                  username: post.userName,
                  id: post.id,
                  commentText: "Harika bir içerik olmuş!",
                  commentUserName: "omer",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
