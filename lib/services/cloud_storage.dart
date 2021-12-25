import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/utils/fires_storage_repos.dart';

class CloudServices extends GetxController {
  double uploadPersentValue = 0.0;
  bool isDoneLocal = false;
  bool isLoadingLocal = false;
  var uploadFileNumberLocal = 0;
  String errorMessageLocal = FirebaseErrorMessages.defaultErrorMessage;
  String? imageUrlLink;

  double get upLoadPersent => uploadPersentValue;
  bool get isLoading => isLoadingLocal;
  bool get isDone => isDoneLocal;
  String get storageUploadErrorMessage => errorMessageLocal;
  get uploadNumber => uploadFileNumberLocal;

  Future<void> uploadFile(
      {required File fileToUpload, required String fileName}) async {
    StorageRepo storageRepo = StorageRepo();
    UploadTask uploadTask = storageRepo.uploadImage(fileName, fileToUpload);
    try {
      var df = await uploadTask;
      String d = await df.ref.getDownloadURL();
      print(d);
      imageUrlLink = d;
      update();
    } on FirebaseException catch (error) {
      if (error.code == 'permission-denied') {
        errorMessageLocal =
            error.message ?? FirebaseErrorMessages.defaultErrorMessage;
        update();
      } else {
        errorMessageLocal = error.code;
        update();
      }
    }
  }
}
