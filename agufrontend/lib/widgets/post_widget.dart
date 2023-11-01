import 'package:agufrontend/resources/auth_methods.dart';
import 'package:agufrontend/resources/comment_methods.dart';
import 'package:agufrontend/resources/post_methods.dart';
import 'package:agufrontend/resources/user_information_methods.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../constants/colors.dart';
import '../constants/utils.dart';
import 'comment_widget.dart';

class PostWidget extends StatefulWidget {
  final int id;
  final String title;
  final String text;
  final int isPublic;
  final String postedTime;
  final String username;
  final bool isProfileScreen;
  final bool isSavedScreen;
  final String? commentText;
  final String? commentUserName;

  const PostWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.isPublic,
    required this.postedTime,
    required this.username,
    this.isProfileScreen = false,
    this.isSavedScreen = false,
    required this.id,
    this.commentText,
    this.commentUserName,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isSaved = false;
  late LocalStorage storage;

  @override
  void initState() {
    super.initState();
    storage = LocalStorage('post_likes'); // Storage anahtarını belirleyin
    getLikedStatus();
    getSavedStatus();
  }

  void getSavedStatus() async {
    await storage.ready;
    bool? savedStatus = storage.getItem('savedStatus_${widget.id}');
    setState(() {
      isSaved = savedStatus ?? false;
    });
  }

  void getLikedStatus() async {
    await storage.ready;
    bool? likedStatus = storage.getItem('likedStatus_${widget.id}');
    setState(() {
      isLiked = likedStatus ?? false;
    });
  }

  void saveLikedStatus(bool liked) async {
    await storage.ready;
    storage.setItem('likedStatus_${widget.id}', liked);
  }

  void saveSavedStatus(bool saved) async {
    await storage.ready;
    storage.setItem('savedStatus_${widget.id}', saved);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isProfileScreen
          ? const EdgeInsets.symmetric(horizontal: 8.0)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(Utils.circleAvatarUrl),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.postedTime,
                          style: TextStyle(color: mainColor),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: mainColor,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          "Takip Et",
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        widget.username == UserInfoMethods.user.userName
                            ? IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  String output =
                                      await PostMethods().deletePost(widget.id);
                                  if (output == "Success") {
                                    Utils().showAlertDialog(
                                        context, "Günlük Başarıyla Silindi!");
                                  } else {
                                    Utils().showAlertDialog(context, output);
                                  }
                                },
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.report_problem,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
                              ),
                        widget.username == UserInfoMethods.user.userName
                            ? const Text(
                                "Sil",
                                style: TextStyle(color: Colors.red),
                              )
                            : const Text(
                                "Şikayet Et",
                                style: TextStyle(color: Colors.red),
                              ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.text,
                    maxLines: 5,
                    style: const TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  widget.text.length > 350
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                content: Text(
                                  widget.text,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Kapat',
                                      style: TextStyle(color: mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                "Devamını Oku...",
                                style: TextStyle(
                                  color: mainColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ))
                      : Container()
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    widget.isPublic == 1 ? Icons.lock_open : Icons.lock_outline,
                    color: mainColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    saveLikedStatus(isLiked);
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : mainColor,
                  ),
                ),
                Text(isLiked ? "Beğenildi" : "Beğen"),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    CommentMethods().getAllCommentsByPostId(widget.id);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String enteredText = '';
                        return AlertDialog(
                          title: const Text('Yorum Ekle'),
                          content: TextField(
                            onChanged: (value) {
                              enteredText = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Paylaş'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.comment_outlined,
                    color: mainColor,
                  ),
                ),
                const Text("Yorum Yap"),
                const SizedBox(width: 20),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        isSaved = !isSaved;
                      });
                      saveSavedStatus(isSaved);
                      String output = "";
                      widget.isSavedScreen
                          ? output =
                              await PostMethods().deleteSavedPost(widget.id)
                          : output = await PostMethods().addSavedPost(
                              AuthMethods.userId, widget.id.toString());
                      if (output == "Success") {
                        widget.isSavedScreen
                            ? Utils().showAlertDialog(
                                context, "Başarıyla Kaldırıldı")
                            : Utils().showAlertDialog(
                                context, "Başarıyla Kaydedildi");
                      } else {
                        setState(() {
                          isSaved = true;
                        });
                        Utils().showAlertDialog(context, output);
                      }
                    },
                    icon: widget.isSavedScreen
                        ? Icon(
                            Icons.bookmark_remove_outlined,
                            color: mainColor,
                          )
                        : Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: mainColor,
                          )),
                widget.isSavedScreen
                    ? const Text("Kaldır")
                    : isSaved
                        ? const Text("Kaydedildi")
                        : const Text("Kaydet"),
              ],
            ),
            CommentMethods.comments.isNotEmpty
                ? const SizedBox(
                    height: 15,
                  )
                : Container(),
            CommentMethods.comments.isNotEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return CommentWidget(
                            commentText: widget.commentText ?? "",
                            userName: widget.commentUserName ?? "",
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
