import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/methods.dart';

class FirestoreRepos {
  FirestoreRepos() {
    firestoreInstance = FirebaseFirestore.instance;
  }
  late FirebaseFirestore firestoreInstance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getNoticesStream() async* {
    yield* firestoreInstance.collection(FirestoreKeys.noticeKey).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNoticesSnapshot() async =>
      firestoreInstance.collection(FirestoreKeys.noticeKey).get();

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminRecords() async {
    return firestoreInstance.collection(FirestoreKeys.adminKey).get();
  }

  Future<void> addANotice(NoticeModel noticeModel) async {
    return firestoreInstance
        .collection(FirestoreKeys.noticeKey)
        .doc(DateTime.now().toString())
        .set(NoticeModel.toMap(noticeModel))
        .whenComplete(() {
      Methods.showToast(toastMessage: 'Posted successfully');
    });
  }

  Future<void> deleteANotice(noticeId) async {
    return firestoreInstance
        .collection(FirestoreKeys.noticeKey)
        .doc(noticeId)
        .delete();
  }
}
