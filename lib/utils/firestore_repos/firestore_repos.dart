import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasah_app/constants.dart';

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
}
