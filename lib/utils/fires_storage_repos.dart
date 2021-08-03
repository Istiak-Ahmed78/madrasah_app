import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  StorageRepo() {
    storageInstance = FirebaseStorage.instance;
  }

  late FirebaseStorage storageInstance;
  UploadTask uploadImage(String filename, File fileToUpload) =>
      storageInstance.ref('Notices/$filename').putFile(fileToUpload);
}
