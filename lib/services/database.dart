import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_operations/models/club.dart';

class Database {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  /// READ
  Stream<QuerySnapshot> getClubsList(String collectionPath) {
    return firebase.collection(collectionPath).snapshots();
  }

  /// CREATE
  Future<void> addClubData(
      {required String collectionPath,
      required Map<String, dynamic> clubAsMap}) async {
    await firebase
        .collection(collectionPath)
        .doc(Club.fromMap(clubAsMap).clubID)
        .set(clubAsMap);
  }

  /// DELETE
  Future<void> deleteClubData(String collectionPath, String clubID) async {
    await firebase.collection(collectionPath).doc(clubID).delete();
  }
}
