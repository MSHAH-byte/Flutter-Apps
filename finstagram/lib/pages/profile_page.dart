import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:get_it/get_it.dart';
import 'package:finstagram/utils/image_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceHeight! * 0.05,
        vertical: _deviceWidth! * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_profileImage(), _postsGridView()],
      ),
    );
  }

  /// Universal image loader: works for URLs and Base64
  Image _loadImage(String? imageString, {BoxFit fit = BoxFit.cover}) {
    if (imageString == null || imageString.isEmpty) {
      return Image.asset("assets/placeholder.png", fit: fit);
    }
    if (imageString.startsWith("http://") ||
        imageString.startsWith("https://")) {
      return Image.network(imageString, fit: fit);
    }
    try {
      return Image.memory(decodeBase64ToBytes(imageString), fit: fit);
    } catch (e) {
      debugPrint("Error decoding Base64: $e");
      return Image.asset("assets/placeholder.png", fit: fit);
    }
  }

  Widget _profileImage() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: _loadImage(_firebaseService!.currentUser!["image"]).image,
        ),
      ),
    );
  }

  Widget _postsGridView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getpostsForUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> posts = snapshot.data!.docs
                .map((e) => e.data() as Map<String, dynamic>)
                .toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> post = posts[index];
                return Container(child: _loadImage(post["imageData"]));
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
        },
      ),
    );
  }
}
