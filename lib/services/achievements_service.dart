import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/achievement_model.dart';

final achievementsServiceProvider = Provider((ref) => AchievementsService());

class AchievementsService {
  Future<List<AchievementModel>> loadAchievements() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("wisdoms").get();

    var result = <AchievementModel>[];
    for (final wisdom in snapshot.docs) {
      final data = wisdom.data();
      result.add(AchievementModel.fromJson(data));
    }

    return result;
  }

  Future<int> getChallengeStatus() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection("userdata").doc(uid).get();

    if (snapshot.data() != null &&
        snapshot.data()!.containsKey("challengeStatus")) {
      return snapshot.data()!["challengeStatus"] as int;
    } else {
      return 0;
    }
  }

  Future<void> incrementChallenge(int increment) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshotRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final snapshot = await snapshotRef.get();

    if (snapshot.data() != null &&
        snapshot.data()!.containsKey("challengeStatus")) {
      final actualStatus = snapshot.data()!["challengeStatus"] as int;

      snapshotRef.set({
        "challengeStatus": actualStatus + increment,
      }, SetOptions(merge: true));
    } else {
      // If field doesn't exist, increment can only be 1
      snapshotRef.set({
        "challengeStatus": 1,
      });
    }
  }

  Future<int> getLevel() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshotRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final snapshot = await snapshotRef.get();

    if (snapshot.data() != null && snapshot.data()!.containsKey("level")) {
      return snapshot.data()!["level"] as int;
    } else {
      return 1;
    }
  }

  Future<void> incrementLevel() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshotRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final snapshot = await snapshotRef.get();

    if (snapshot.data() != null && snapshot.data()!.containsKey("level")) {
      final actualLevel = snapshot.data()!["level"] as int;

      snapshotRef.set({
        "level": actualLevel + 1,
      }, SetOptions(merge: true));
    } else {
      snapshotRef.set({
        "level": 1,
      });
    }
  }
}
