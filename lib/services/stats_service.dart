import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/prayer_activity_model.dart';
import 'package:qadha/utils/date_utils.dart';

final statsServiceProvider = Provider((ref) => StatsService());

class StatsService {
  Future<List<PrayerActivityModel>> loadActivities() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDataRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final statsSnapshot = await userDataRef.collection("stats").get();

    var result = <PrayerActivityModel>[];
    for (final prayer in statsSnapshot.docs) {
      final prayerName = prayer.id;
      final prayers = prayer.data()["activities"] as Map<String, dynamic>?;

      if (prayers != null) {
        for (final rawDate in prayers.keys) {
          result.add(PrayerActivityModel(prayerName,
              parseDate(rawDate), (prayers[rawDate]! as int)));
        }
      }
    }

    return result;
  }
}
