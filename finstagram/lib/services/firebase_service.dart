import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:finstagram/utils/image_utils.dart';

const String USER_COLLECTION = 'users';
const String POSTS_COLLECTION = 'posts';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map<String, dynamic>? currentUser;

  FirebaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;

      String base64Image = await encodeImageFileToBase64(image);

      await _db.collection(USER_COLLECTION).doc(userId).set({
        "name": name,
        "email": email,
        "image": base64Image,
      });

      return true;
    } catch (e) {
      print("Error in registerUser: $e");
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        currentUser = await getUserData(uid: userCredential.user!.uid);
        return true;
      }
      return false;
    } catch (e) {
      print("Error in loginUser: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    DocumentSnapshot doc = await _db.collection(USER_COLLECTION).doc(uid).get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<bool> postImage(File imageFile) async {
    try {
      String userId = _auth.currentUser!.uid;
      String base64Image = await encodeImageFileToBase64(imageFile);

      await _db.collection(POSTS_COLLECTION).add({
        "userId": userId,
        "timestamp": Timestamp.now(),
        "imageData": base64Image,
      });

      return true;
    } catch (e) {
      print("Error posting image: $e");
      return false;
    }
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(POSTS_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getpostsForUsers() {
    String userId = _auth.currentUser!.uid;
    return _db
        .collection(POSTS_COLLECTION)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
