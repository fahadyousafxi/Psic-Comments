import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {

  String? uId;

   CreateScreen({required this.uId, Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  TextEditingController _name = TextEditingController();
  TextEditingController _Comment = TextEditingController();
  final _fireStore = FirebaseFirestore.instance.collection("users");


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Create'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [

            TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: 'Name'
              ),
            ),

            SizedBox(height: 11,),
            TextField(
              controller: _Comment,
              decoration: InputDecoration(
                hintText: 'Comment'
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){

              // String uid = DateTime.now().microsecondsSinceEpoch.toString();

              _fireStore.doc(widget.uId.toString()).update({
                'username' : _name.text,
                'comments' : _Comment.text,
              });


              // _fireStore.doc(uid).set({
              //   'uId' : uid,
              //   'username' : _name.text,
              //   'comments' : _Comment.text,
              // });

              }, child: Text('Create'))


          ],
        ),
      ),
    );
  }
}
