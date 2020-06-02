import 'package:agora_ogaboss/models/user.dart';
import 'package:agora_ogaboss/pages/HomePage.dart';
import 'package:agora_ogaboss/pages/products_web_fetcher.dart';
import 'package:agora_ogaboss/widgets/HeaderWidget.dart';
import 'package:agora_ogaboss/widgets/PostWidget.dart';
import 'package:agora_ogaboss/widgets/ProgressWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeLinePage extends StatefulWidget {
  final User gCurrentUser;

  TimeLinePage({this.gCurrentUser});

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  List<Post> posts;
  List<String> followingsList = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  retrieveTimeline() async {
    QuerySnapshot querySnapshot = await timelineRefrence
        .document(widget.gCurrentUser.id)
        .collection("timelinePosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();

    List<Post> allPosts = querySnapshot.documents
        .map((document) => Post.fromDocument(document))
        .toList();

    setState(() {
      this.posts = allPosts;
    });
  }

  retrieveFollowings() async {
    QuerySnapshot querySnapshot = await followingRefrence
        .document(currentUser.id)
        .collection("userFollowing")
        .getDocuments();

    setState(() {
      followingsList = querySnapshot.documents
          .map((document) => document.documentID)
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveTimeline();
    retrieveFollowings();
  }

  createUserTimeline() {
    if (posts == null) {
      return circularProgress();
    } else {
      return ListView(
        children: posts,
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, isAppTittle: true),
//      drawer: Theme(
//          data: Theme.of(context).copyWith(
//            canvasColor:
//                Colors.black, //This will change the drawer background to blue.
//            //other styles
//          ),
//          child: Drawer(
//            elevation: 16.0,
//            semanticLabel: 'drawer',
//            child: ListView(
//              children: <Widget>[
//                InkWell(
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => MyHustle(),
//                      ),
//                    );
//                  },
//                  child: ListTile(
//                    title: Text(
//                      'My Hustle',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    leading: Icon(
//                      Icons.directions_run,
//                      color: Colors.blue,
//                    ),
//                  ),
//                ),
//                Divider(),
//                InkWell(
//                  onTap: () => print("about"),
//                  child: ListTile(
//                    title: Text(
//                      'About',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    leading: Icon(
//                      Icons.help,
//                      color: Colors.green,
//                    ),
//                  ),
//                ),
//
//                InkWell(
//                  onTap: () => print("not functional"),
//                  child: ListTile(
//                    title: Text(
//                      'Logout',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    leading: Icon(
//                      Icons.exit_to_app,
//                      color: Colors.green,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          )),
      body: RefreshIndicator(

        child: createUserTimeline(),
        onRefresh: () => retrieveTimeline(),
      ),
    );
  }
}
