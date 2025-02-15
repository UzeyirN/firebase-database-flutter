import 'package:firebase_operations/models/club.dart';
import 'package:firebase_operations/services/database.dart';
import 'package:firebase_operations/services/time_calculator.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddClubViewModel extends ChangeNotifier {
  Database database = Database();

  Future<void> addClub(
      {required String clubName,
      required String clubCoach,
      required DateTime foundedDate}) async {
    Club club = Club(
      clubID: DateTime.now().toIso8601String(),
      clubName: clubName,
      clubCoach: clubCoach,
      foundedDate: TimeCalculator.dateTimeToTimestamp(foundedDate),
    );

    database.addClubData(
      collectionPath: collectionPath,
      clubAsMap: club.toMap(),
    );
  }
}
