import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? urlImage;

  Future<void> pushImage(XFile image) async {
    try {
      final pathImage = 'logo/${image.name}';

      Reference storageRef = _firebaseStorage.ref().child(pathImage);

      UploadTask uploadTask = storageRef.putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      urlImage = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return;
    }
  }
}
