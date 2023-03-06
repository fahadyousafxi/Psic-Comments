import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  String? uId;

  CreateScreen({required this.uId, Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final _fireStore = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 11,
            ),
            TextField(
              controller: _comment,
              decoration: const InputDecoration(hintText: 'Comment'),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  // String uid = DateTime.now().microsecondsSinceEpoch.toString();

                  _fireStore.doc(widget.uId.toString()).update({
                    'username': _name.text,
                    'comments': _comment.text,
                  });
                  Navigator.pop(context);

                  // _fireStore.doc(uid).set({
                  //   'uId' : uid,
                  //   'username' : _name.text,
                  //   'comments' : _Comment.text,
                  // });
                },
                child: const Text('Create'))
          ],
        ),
      ),
    );
  }
}
