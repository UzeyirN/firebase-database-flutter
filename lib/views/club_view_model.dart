import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_operations/models/club.dart';
import 'package:firebase_operations/services/database.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ClubViewModel extends ChangeNotifier {
  Database database = Database();

  /// READ
  Stream<List<Club>> getClubsList() {
    Stream<List<DocumentSnapshot<Object?>>> streamListDocs = database
        .getClubsList(collectionPath)
        .map((querySnapshots) => querySnapshots.docs);

    Stream<List<Club>> listClubs = streamListDocs.map(
      (listOfDocSnaps) => listOfDocSnaps
          .map(
            (doc) => Club.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList(),
    );

    return listClubs;
  }

  /// DELETE

  Future<void> deleteClub(Club club) async {
    await database.deleteClubData(collectionPath, club.clubID);
  }
}
