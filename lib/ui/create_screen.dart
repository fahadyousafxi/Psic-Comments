import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final String uId;
  final String name;
  final String comment;

  const CreateScreen({
    super.key,
    required this.uId,
    required this.name,
    required this.comment,
  });

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final _fireStore = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    _name.text = widget.name;
    _comment.text = widget.comment;
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
              controller: _name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 11,
            ),
            TextField(
              controller: _comment,
              decoration: const InputDecoration(hintText: 'Comment'),
              maxLines: 4,
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
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
