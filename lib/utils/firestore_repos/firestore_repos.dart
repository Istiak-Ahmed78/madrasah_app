import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/models/notice_model.dart';

class FirestoreRepos {
  FirestoreRepos() {
    firestoreInstance = FirebaseFirestore.instance;
  }
  late FirebaseFirestore firestoreInstance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getNoticesStream() async* {
    yield* firestoreInstance
        .collection(FirestoreKeys.noticeKey)
        .orderBy('NoticeId', descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getNoticesSnapshot() async =>
      firestoreInstance
          .collection(FirestoreKeys.noticeKey)
          .orderBy('NoticeId', descending: true)
          .get();

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminRecords() async {
    return firestoreInstance.collection(FirestoreKeys.adminKey).get();
  }

  Future<void> addANotice(NoticeModel noticeModel) async {
    return firestoreInstance
        .collection(FirestoreKeys.noticeKey)
        .doc(noticeModel.noticeId)
        .set(NoticeModel.toMap(noticeModel));
  }

  Future<void> updateNotice(
    NoticeModel noticeModel,
  ) {
    CollectionReference _collectionReference =
        firestoreInstance.collection(FirestoreKeys.noticeKey);

    return _collectionReference
        .doc(_collectionReference.doc(noticeModel.noticeId).id)
        .update(NoticeModel.toMap(noticeModel));
  }

  Future<void> deleteANotice(noticeId) {
    print('NoticeId: $noticeId');

    return firestoreInstance.collection('Notices').doc(noticeId).delete();
  }
}
