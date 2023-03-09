import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/comments_model.dart';

class CommentsProviders with ChangeNotifier {
  CommentsModel? commentsModel;

  // List<CommentsModel> searchProductsList = [];

  productModels(QueryDocumentSnapshot element) {
    commentsModel = CommentsModel(
      comments: element.get("comments"),
      username: element.get("username"),
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
      productModels(element);
      // productModel = ProductModel(
      //   productImage1: element.get("productImage1"),
      //   productName: element.get("productName"),
      //   productDescription: element.get("productDescription"),
      //   productCurrentBid: element.get("productCurrentBid"),
      //   // bidDateTimeLeft: element.get("bidDateTimeLeft"),
      // );
      newList.add(commentsModel!);
    }
    commentsList = newList;
    notifyListeners();
  }

  List<CommentsModel> get getCommentsList {
    return commentsList;
  }
}
