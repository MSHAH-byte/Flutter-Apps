import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:get_it/get_it.dart';
import 'package:finstagram/utils/image_utils.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _postListView());
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getLatestPosts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> posts = snapshot.data!.docs
              .map((e) => e.data() as Map<String, dynamic>)
              .toList();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> post = posts[index];
              return Container(
                height: 250,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: decodeBase64ToImage(post["imageData"]),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
