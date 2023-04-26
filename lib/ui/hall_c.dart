import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psic_comments/controller/api.dart';
import 'package:psic_comments/ui/update_comment.dart';

import '../providers/comments_provider.dart';

class HallC extends StatefulWidget {
  const HallC({Key? key}) : super(key: key);

  @override
  State<HallC> createState() => _HallCState();
}

class _HallCState extends State<HallC> {
  CommentsProviders commentsProviders = CommentsProviders();

  final _fireStore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    commentsProviders = Provider.of(context);
    commentsProviders.fetchComments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hall C'),
      ),
      body: commentsProviders.getCommentsList.any((element) {
        return element.hall == 'Hall C';
      })
          ? ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: commentsProviders.getCommentsList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = commentsProviders.getCommentsList[index];
                var sent = commentsProviders.getCommentsList[index].sent;
                if (data.hall == 'Hall C') {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                    child: Container(
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          width: 4,
                          color: sent == false ? Colors.grey : Colors.green,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text('User Name: ${data.username}'),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Text('Comment: ${data.comments}'),
                            ),
                            const SizedBox(height: 10),
                            Text('Hall: ${data.hall}'),
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
                                        builder: (context) => UpdateComment(
                                          uId: data.uId!,
                                          name: data.username!,
                                          comment: data.comments!,
                                          hall: data.hall!,
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
                                sent == true
                                    ? CircularProgressIndicator()
                                    : IconButton(
                                        color: sent == false
                                            ? Colors.grey
                                            : Colors.green,
                                        onPressed: () async {
                                          ApiController apiController =
                                              ApiController();
                                          await _fireStore
                                              .doc(data.uId.toString())
                                              .update({
                                            'sent': true,
                                          });

                                          await apiController.apply(
                                            name: data.username,
                                            comment: data.comments,
                                            hall: data.hall,
                                            secretKey: 'JFwnU@r#bC3sG4vi',
                                            context: context,
                                            data: data.uId,
                                          );

                                          setState(() {});
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
                }
                return Container();
              },
            )
          : Center(
              child: Text('No Comment'),
              //   child: CircularProgressIndicator(
              //   color: Colors.red,
              // ),
            ),
    );
  }
}
