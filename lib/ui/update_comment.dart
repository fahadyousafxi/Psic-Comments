import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateComment extends StatefulWidget {
  final String uId;
  final String name;
  final String comment;
  final String hall;

  const UpdateComment({
    super.key,
    required this.uId,
    required this.name,
    required this.comment,
    required this.hall,
  });

  @override
  State<UpdateComment> createState() => _UpdateCommentState();
}

class _UpdateCommentState extends State<UpdateComment> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _hall = TextEditingController();
  final _fireStore = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    _name.text = widget.name;
    _comment.text = widget.comment;
    _hall.text = widget.hall;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Your Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: _hall,
              enabled: false,
            ),
            TextField(
              controller: _name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _comment,
              decoration: const InputDecoration(hintText: 'Comment'),
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () {
                  _fireStore.doc(widget.uId.toString()).update({
                    'username': _name.text,
                    'comments': _comment.text,
                  });
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
