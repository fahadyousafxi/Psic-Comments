import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/comments_model.dart';

class CommentsProviders with ChangeNotifier {
  CommentsModel? commentsModel;

  // List<CommentsModel> searchProductsList = [];

  commentsModels(QueryDocumentSnapshot element) {
    commentsModel = CommentsModel(
      comments: element.get("comments"),
      username: element.get("username"),
      hall: element.get("hall"),
      createdAt: element.get("createdAt"),
      sent: element.get('sent'),
      uId: element.get("uId"),
    );
    // searchProductsList.add(commentsModel!);
  }

  List<CommentsModel> commentsList = [];

  fetchComments() async {
    List<CommentsModel> newList = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").get();

    for (var element in snapshot.docs) {
      commentsModels(element);

      newList.add(commentsModel!);
    }
    commentsList = newList;
    notifyListeners();
  }

  List<CommentsModel> get getCommentsList {
    return commentsList;
  }
}
