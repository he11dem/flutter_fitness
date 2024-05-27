import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class UsersCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addUsersCollection(String id, String name, String email,
      String password, String check) async {
    try {
      await _firebaseFirestore.collection('users').doc(id).set({
        'uid': id,
        'name': name,
        'image': null,
        'email': email,
        'password': password,
        'check': check,
        'gender': '',
        'height': '',
        'width': '',
      });
    } catch (e) {
      return;
    }
  }

  Future<void> editUserCollection(
    dynamic docs,
    String name,
    String image,
    String gender,
    String height,
    String width,
  ) async {
    try {
      await _firebaseFirestore.collection('users').doc(docs.id).update({
        'name': name,
        'image': image,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> deleteUserCollection(dynamic docs) async {
    try {
      await _firebaseFirestore.collection('users').doc(docs.id).delete();
    } catch (e) {
      return;
    }
  }

  Future<void> updateImageUser(
    dynamic docs,
    String image,
  ) async {
    try {} catch (e) {
      await _firebaseFirestore.collection('users').doc(docs.id).update({
        'image': image,
      });

      return;
    }
  }

  getUser() {}
}
