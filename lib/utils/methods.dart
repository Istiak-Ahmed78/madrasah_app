import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/views/shared_widgets/shared_widgets.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Methods {
  static void showToast(
      {required String toastMessage,
      Color backGroundColor = CResources.orange,
      Toast duration = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: duration,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backGroundColor,
        textColor: CResources.white,
        fontSize: 16.0);
  }

  static void emtyEmailWarning(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: const Text(
                  "To procceed, enter your valid email adress in the email field."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ]);
        });
  }

  static void showVerificationAskingDialog(context, user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Your email adress need verification"),
              content: const Text(
                  "Your email is not verified.You cannot logIn without verifing your email adress."),
              actions: [
                TextButton(
                    onPressed: () async {
                      await Provider.of<AuthState>(context, listen: false)
                          .sendVerificationEmail(user);
                      Navigator.pop(context);
                    },
                    child: const Text('Send verification email again')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ]);
        });
  }

  static Future<void> showLoadingIndicator(
      {required BuildContext context,
      String? text,
      Future<void>? workTodo}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.black87,
          content: LoadingIndicator(text: text),
        );
      },
    );
    if (workTodo != null) {
      await Future.delayed(Duration.zero, () {
        workTodo.then((_) {
          Navigator.pop(context);
        });
      });
    }
  }

  static Future<void> showUploadLoading(
      {required BuildContext context,
      required double persent,
      required bool isDone,
      void workTodo}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.black87,
          content:
              LoadingIndicator(text: getUploadNoticeSring(isDone, persent)),
        );
      },
    );
    if (isDone) {
      Navigator.pop(context);
    }
  }

  static List<NoticeModel> decodeNoticeModel(
      QuerySnapshot<Map<String, dynamic>>? querySnapshot) {
    List<NoticeModel> shoppingCartList = [];
    if (querySnapshot != null) {
      for (final item in (querySnapshot).docs) {
        shoppingCartList.add(NoticeModel.fromMap(item.data()));
      }
      return shoppingCartList;
    } else {
      return shoppingCartList;
    }
  }

  static Future<List<File>?> pickFils() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    List<File> files;
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else
      return null;
  }

  static String getUploadNoticeSring(
    bool isDone,
    double loadingProgressStatus,
  ) {
    if (!isDone) {
      return 'Uploading $loadingProgressStatus';
    } else
      return 'Done uploading';
  }
}
