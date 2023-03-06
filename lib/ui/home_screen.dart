
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psic_comments/ui/comments.dart';

import '../providers/comments_provider.dart';
import 'create_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CommentsProviders commentsProviders = CommentsProviders();



  @override
  void initState() {
    CommentsProviders commentsProviders =
    Provider.of(context, listen: false);
    // commentsProviders.fitchComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    commentsProviders = Provider.of(context);
    commentsProviders.fitchComments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewComments()));
              }, child: Text(' View ')),
            SizedBox(height: 33,),
            // ElevatedButton(onPressed: (){
            //
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen()));
            //
            //
            // }, child: Text(' Create ')),

          ],
        ),
      )
    );
  }
}
