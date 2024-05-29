import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class UserProfileCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addUserProfileCollection(
    String uid,
    String height,
    String weight,
    String dateOfBirth,
    String gender,
  ) async {
    try {
      await _firebaseFirestore.collection('userProfiles').doc(uid).set({
        'uid': uid,
        'height': height,
        'weight': weight,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> editUserProfileCollection(
    dynamic docs,
    String height,
    String weight,
    String dateOfBirth,
    String gender,
  ) async {
    try {
      await _firebaseFirestore.collection('userProfiles').doc(docs.id).update({
        'height': height,
        'weight': weight,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> deleteUserProfileCollection(dynamic docs) async {
    try {
      await _firebaseFirestore.collection('userProfiles').doc(docs.id).delete();
    } catch (e) {
      return;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserProfile(
      String uid) async {
    try {
      return await _firebaseFirestore.collection('userProfiles').doc(uid).get();
    } catch (e) {
      return null; // Или выбросьте исключение, если это необходимо.
    }
  }
}
