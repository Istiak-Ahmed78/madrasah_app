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

  double get upLoadPersent => uploadPersentValue;
  bool get isLoading => isLoadingLocal;
  bool get isDone => isDoneLocal;
  String get storageUploadErrorMessage => errorMessageLocal;
  get uploadNumber => uploadFileNumberLocal;

  Future<void> uploadFiles(
      {required String filename, required File fileToUpload}) async {
    notifyListeners();
    UploadTask uploadTask =
        services<StorageRepo>().uploadImage(filename, fileToUpload);
    try {
      uploadTask.snapshotEvents.listen((event) {
        uploadPersentValue =
            ((event.bytesTransferred / event.totalBytes) * 100).roundToDouble();
        notifyListeners();
      }).onDone(() {
        isLoadingLocal = false;
        notifyListeners();
      });
    } on FirebaseException catch (error) {
      if (error.code == 'permission-denied') {
        isLoadingLocal = false;
        errorMessageLocal =
            error.message ?? FirebaseErrorMessages.defaultErrorMessage;
        notifyListeners();
      } else {
        isLoadingLocal = false;
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

  Future<void> uploadMultipleFile(List<File> fileList) async {
    String fileName = DateTime.now().toString();
    isLoadingLocal = true;
    isDoneLocal = false;
    notifyListeners();
    for (final i in fileList) {
      uploadFileNumberLocal = fileList.indexOf(i) + 1;
      notifyListeners();
      uploadFiles(filename: fileName, fileToUpload: i);
    }

    isDoneLocal = true;
    notifyListeners();
  }
}
