import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:madrasah_app/utils/methods.dart';

class FileAttechState extends ChangeNotifier {
  List<File> attachedFilesLocal = [];

  List<File> get attachedFiles => attachedFilesLocal;

  void pickFiels() async {
    List<File>? files = await Methods.pickFils();
    if (files != null) {
      if (!isAlreadyIntheList(files)) {
        attachedFilesLocal.addAll(files);
        notifyListeners();
      }
    }
  }

  bool isAlreadyIntheList(List<File> files) {
    bool test = true;
    for (final i in files) {
      test = attachedFiles.contains(i);
    }
    return test;
  }

  void removeAItem(int index) {
    attachedFiles.removeAt(index);
    notifyListeners();
  }

  void clearLisr() {
    attachedFiles.clear();
  }
}
