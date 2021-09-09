import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/views/shared_widgets/shared_widgets.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    displayADialog(
        context: context,
        content: const Text(
            "To procceed, enter your valid email adress in the email field."),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok')),
        ]);
  }

  static void showVerificationAskingDialog(context, user) {
    displayADialog(
        context: context,
        content: const Text(
            "Your email is not verified.You cannot logIn without verifing your email adress."),
        title: const Text("Your email adress need verification"),
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
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //           title: const Text("Your email adress need verification"),
    //           content: const Text(
    //               "Your email is not verified.You cannot logIn without verifing your email adress."),
    //           actions: [
    //             TextButton(
    //                 onPressed: () async {
    //                   await Provider.of<AuthState>(context, listen: false)
    //                       .sendVerificationEmail(user);
    //                   Navigator.pop(context);
    //                 },
    //                 child: const Text('Send verification email again')),
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child: const Text('Ok')),
    //           ]);
    //     });
  }

  static void deleteConfirmationPopUp(
      {required BuildContext context,
      String noticeTitle = '',
      required Function onDelelte}) {
    return displayADialog(
        context: context,
        title: Text('Want to delete?'),
        content: Text('Are you sure about deleting \'$noticeTitle..\'?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              onDelelte();
            },
            // onPressed: () {
            //   print('delete');
            // },
            child: Text('Yes, delete'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No, cancel'))
        ]);
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
      {required BuildContext context, required Future<void> workTodo}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            backgroundColor: Colors.black87,
            content: LoadingIndicator(
              text: 'Posting the notice',
            ));
      },
    );
    await workTodo;
    Navigator.pop(context);
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

  static String getUploadNoticeSring(
    bool isDone,
    double loadingProgressStatus,
  ) {
    if (!isDone) {
      return 'Uploading $loadingProgressStatus';
    } else
      return 'Done uploading';
  }

  static launchUrl(String urlToLauch) async {
    if (await canLaunch(urlToLauch)) {
      launch(urlToLauch);
    } else {
      Methods.showToast(toastMessage: 'Couldnot launch');
    }
  }

  static void displayADialog(
      {required BuildContext context,
      Widget? content,
      Widget? title,
      List<Widget>? actions,
      bool isDissmissable = false}) {
    showDialog(
        context: context,
        barrierDismissible: isDissmissable,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            actions: actions,
            content: content,
          );
        });
  }

  // static void pay() {
  //   Sslcommerz sslcommerz = Sslcommerz(
  //       initializer: SSLCommerzInitialization(
  //           //   ipn_url: "www.ipnurl.com",
  //           multi_card_name: "visa,master,bkash",
  //           currency: SSLCurrencyType.BDT,
  //           product_category: "Food",
  //           sdkType: SSLCSdkType.TESTBOX,
  //           store_id: "ghost611797ae8b447",
  //           store_passwd: "ghost611797ae8b447@ssl",
  //           total_amount: 10.0,
  //           tran_id: "1231321321321312"));
  //   sslcommerz.payNow();
  // }
}
