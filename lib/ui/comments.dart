
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psic_comments/ui/create_screen.dart';

import '../providers/comments_provider.dart';

class ViewComments extends StatefulWidget {
  const ViewComments({Key? key}) : super(key: key);

  @override
  State<ViewComments> createState() => _ViewCommentsState();
}

class _ViewCommentsState extends State<ViewComments> {

  CommentsProviders commentsProviders = CommentsProviders();

  @override
  void initState() {
    CommentsProviders commentsProviders =
    Provider.of(context, listen: false);
    // commentsProviders.fitchComments();
    super.initState();
  }

  final _fireStore = FirebaseFirestore.instance.collection("users");


  @override
  Widget build(BuildContext context) {
    commentsProviders = Provider.of(context);
    commentsProviders.fitchComments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),

      ),
      body: SizedBox(
        child:
        ListView.builder(
          itemCount: commentsProviders.getCommentsList.length,
          itemBuilder: (BuildContext context, int index) {

            var data = commentsProviders.getCommentsList[index];

            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(

                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.black)
                ),
                child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('User Name: ' + data.username.toString()),
                    SizedBox(height: 22,),
                    Text('Comment: ' + data.comments.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen(uId: data.uId.toString(),)));

                        }, icon: Icon(Icons.edit),),
                        IconButton(onPressed: (){

                          _fireStore.doc(data.uId.toString()).delete();

                          setState(() {

                          });

                        }, icon: Icon(Icons.delete),),
                        IconButton(onPressed: (){


                        }, icon: Icon(Icons.send),)
                      ],
                    )
                  ],
                )),
              ),
            );

          },),
      ),
    );
  }
}
