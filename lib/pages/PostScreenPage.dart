import 'package:agora_ogaboss/pages/HomePage.dart';
import 'package:agora_ogaboss/widgets/HeaderWidget.dart';
import 'package:agora_ogaboss/widgets/PostWidget.dart';
import 'package:agora_ogaboss/widgets/ProgressWidget.dart';
import 'package:flutter/material.dart';

class PostScreenPage extends StatelessWidget {

  final String userId;
  final String postId;
  PostScreenPage({this.userId,this.postId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsReference.document(userId).collection("usersPosts").document(postId).get(),
      builder: (context, dataSnapshot){
        if(!dataSnapshot.hasData)
          {
            return circularProgress();
          }

        Post post = Post.fromDocument(dataSnapshot.data);
        return Center(
          child:  Scaffold(
            appBar: header(context, strTittle: post.description),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
