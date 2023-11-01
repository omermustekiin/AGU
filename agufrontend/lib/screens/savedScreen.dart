import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../resources/post_methods.dart';
import '../widgets/drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/post_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<PostModel> savedPosts = [];

  @override
  void initState() {
    super.initState();
    fetchSavedPosts();
  }

  Future<void> fetchSavedPosts() async {
    try {
      List<PostModel> savedPosts = await PostMethods().getAllSavedPosts();

      setState(() {
        this.savedPosts = savedPosts;
      });
    } catch (e) {
      debugPrint('Error fetching saved posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: ListView.builder(
        itemCount: savedPosts.length,
        itemBuilder: (BuildContext context, int index) {
          List<PostModel> sortedPosts = savedPosts.reversed.toList();
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
                  isSavedScreen: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
