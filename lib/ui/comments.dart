import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psic_comments/controller/api.dart';
import 'package:psic_comments/ui/create_screen.dart';

import '../providers/comments_provider.dart';

class ViewComments extends StatefulWidget {
  const ViewComments({Key? key}) : super(key: key);

  @override
  State<ViewComments> createState() => _ViewCommentsState();
}

class _ViewCommentsState extends State<ViewComments> {
  CommentsProviders commentsProviders = CommentsProviders();

  @override
  void initState() {
    CommentsProviders commentsProviders = Provider.of(context, listen: false);
    // commentsProviders.fitchComments();
    super.initState();
  }

  final _fireStore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    commentsProviders = Provider.of(context);
    commentsProviders.fetchComments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interact'),
      ),
      body: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: commentsProviders.getCommentsList.length,
        itemBuilder: (BuildContext context, int index) {
          var data = commentsProviders.getCommentsList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
            child: Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text('User Name: ${data.username}'),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text('Comment: ${data.comments}'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateScreen(
                                  uId: data.uId!,
                                  name: data.username!,
                                  comment: data.comments!,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {
                            _fireStore.doc(data.uId).delete();

                            setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          color: Colors.green,
                          onPressed: () async {
                            ApiController apiController = ApiController();
                            await apiController.apply(
                              name: data.username,
                              comment: data.comments,
                              secretKey: 'JFwnU@r#bC3sG4vi',
                              context: context,
                            );
                          },
                          icon: const Icon(Icons.send),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
