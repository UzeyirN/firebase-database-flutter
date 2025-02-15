import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  String clubID;
  String clubName;
  String clubCoach;
  Timestamp foundedDate;

  Club(
      {required this.clubID,
      required this.clubName,
      required this.clubCoach,
      required this.foundedDate});

  Map<String, dynamic> toMap() => {
        'clubID': clubID,
        'clubName': clubName,
        'clubCoach': clubCoach,
        'foundedDate': foundedDate,
      };

  factory Club.fromMap(Map<String, dynamic> map) => Club(
        clubID: map['clubID'] as String,
        clubName: map['clubName'] as String,
        clubCoach: map['clubCoach'] as String,
        foundedDate: map['foundedDate'] as Timestamp,
      );
}
