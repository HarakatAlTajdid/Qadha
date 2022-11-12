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
          result.add(PrayerActivityModel(
              prayerName, parseDate(rawDate), (prayers[rawDate]! as int)));
        }
      }
    }

    return result;
  }

  Future<void> incrementActivity(
      String type, DateTime date, int increment) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDataRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final statsDocRef = userDataRef.collection("stats").doc(type);
    final statsSnapshot = await statsDocRef.get();

    if (statsSnapshot.data() != null &&
        statsSnapshot.data()!.containsKey("activities")) {
      final activities =
          statsSnapshot.data()!["activities"] as Map<String, dynamic>;
      
      if (activities.containsKey(formatDate(date))) {
        if (activities[formatDate(date)] + increment > 0) {
          activities[formatDate(date)] += increment;
        }
      } else {
        activities[formatDate(date)] = 1;
      }

      statsDocRef.set({
        "activities": activities,
      }, SetOptions(merge: true));
    } else {
      statsDocRef.set({
        "activities": {formatDate(date): 1}
      }, SetOptions(merge: true));
    }

    if (statsSnapshot.data() != null && statsSnapshot.data()!.containsKey("remaining")) {
      var remaining = statsSnapshot.data()!["remaining"] as int;
      remaining -= increment;

      if (remaining >= 0) {
        statsDocRef.set({"remaining": remaining}, SetOptions(merge: true));
      }
    }
  }

  Future<int> getRemainingPrayers(String type) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDataRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final statsDocRef = userDataRef.collection("stats").doc(type);
    final statsSnapshot = await statsDocRef.get();

    if (statsSnapshot.data() != null &&
        statsSnapshot.data()!.containsKey("remaining")) {
      return statsSnapshot.data()!["remaining"] as int;
    } else {
      return 0;
    }
  }
}
