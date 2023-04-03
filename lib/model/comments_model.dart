import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsModel {
  String? comments;
  String? username;
  String? hall;
  Timestamp? createdAt;
  bool? sent;
  String? uId;

  CommentsModel({
    this.comments,
    this.username,
    this.hall,
    this.createdAt,
    this.sent,
    this.uId,
  });
}
