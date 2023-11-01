import 'package:agufrontend/resources/post_methods.dart';
import 'package:flutter/material.dart';

import '../constants/utils.dart';
import '../model/post_model.dart';
import '../resources/user_information_methods.dart';
import '../widgets/drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/post_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<PostModel> privatePosts = [];
  List<PostModel> publicPosts = [];

  @override
  void initState() {
    super.initState();
    fetchUserPosts();
  }

  Future<void> fetchUserPosts() async {
    try {
      List<PostModel> privatePosts = await PostMethods().getUserPrivatePosts(0);
      List<PostModel> publicPosts = await PostMethods().getUserPrivatePosts(1);

      setState(() {
        this.privatePosts = privatePosts;
        this.publicPosts = publicPosts;
      });
    } catch (e) {
      print('Error fetching public posts: $e');
      // Handle error scenario
    }
  }

  @override
  Widget build(BuildContext context) {
    //Uint8List bytes = UserInfoMethods.user.avatar.buffer.asUint8List();
    //Utils().uint8ListToUrl(bytes);

    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    "assets/images/welcomebackground.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.24),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        //  backgroundImage: MemoryImage(bytes),
                        backgroundImage: NetworkImage(Utils.circleAvatarUrl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              UserInfoMethods.user.userName,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Herkese Açık Günlüklerim",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Gizli Günlüklerim",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (publicPosts.isEmpty)
                  const Expanded(
                    child: Center(
                        child: Text(
                            "      Herkese açık günlüğünüz bulunmamaktadır.")),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: publicPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<PostModel> sortedPosts =
                            publicPosts.reversed.toList();
                        sortedPosts.sort(
                            (b, a) => a.postedTime.compareTo(b.postedTime));
                        PostModel post = sortedPosts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              PostWidget(
                                title: post.title,
                                text: post.text,
                                isPublic: post.isPublic,
                                postedTime: post.postedTime,
                                username: post.userName,
                                isProfileScreen: true,
                                id: post.id,
                                // Kullanıcı adını buradan geçirin
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                if (privatePosts.isEmpty)
                  const Expanded(
                    child: Center(
                        child: Text("      Gizli günlüğünüz bulunmamaktadır.")),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: privatePosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<PostModel> sortedPosts =
                            privatePosts.reversed.toList();
                        sortedPosts.sort(
                            (b, a) => a.postedTime.compareTo(b.postedTime));
                        PostModel post = sortedPosts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              PostWidget(
                                title: post.title,
                                text: post.text,
                                isPublic: post.isPublic,
                                postedTime: post.postedTime,
                                username: post.userName,
                                isProfileScreen: true,
                                id: post.id,
                                // Kullanıcı adını buradan geçirin
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
