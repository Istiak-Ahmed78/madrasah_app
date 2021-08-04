import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/utils/fires_storage_repos.dart';
import 'package:madrasah_app/utils/methods.dart';

class StorageState extends ChangeNotifier {
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
    UploadTask uploadTask =
        services<StorageRepo>().uploadImage(fileName, fileToUpload);
    try {
      var df = await uploadTask;
      String d = await df.ref.getDownloadURL();
      print(d);
      imageUrlLink = d;
      notifyListeners();
    } on FirebaseException catch (error) {
      if (error.code == 'permission-denied') {
        errorMessageLocal =
            error.message ?? FirebaseErrorMessages.defaultErrorMessage;
        notifyListeners();
      } else {
        errorMessageLocal = error.code;
        notifyListeners();
      }
      Methods.showToast(toastMessage: errorMessageLocal);
    }
  }

  void gotoInitial() {
    isDoneLocal = false;
    isLoadingLocal = false;
    uploadPersentValue = 0.0;
    notifyListeners();
  }
}
