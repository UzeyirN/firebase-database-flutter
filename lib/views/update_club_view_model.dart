import 'package:firebase_operations/models/club.dart';
import 'package:firebase_operations/services/database.dart';
import 'package:firebase_operations/services/time_calculator.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UpdateClubViewModel extends ChangeNotifier {
  Database database = Database();

  Future<void> updateClub({
    required String clubName,
    required String clubCoach,
    required DateTime foundedDate,
    required Club club,
  }) async {
    Club updatedClub = Club(
      clubID: club.clubID,
      clubName: clubName,
      clubCoach: clubCoach,
      foundedDate: TimeCalculator.dateTimeToTimestamp(foundedDate),
    );

    database.addClubData(
      collectionPath: collectionPath,
      clubAsMap: updatedClub.toMap(),
    );
  }
}
