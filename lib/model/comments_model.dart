import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsModel {
  String? comments;
  String? username;
  Timestamp? createdAt;
  String? uId;

  CommentsModel({
    this.comments,
    this.username,
    this.createdAt,
    this.uId,
  });
}
