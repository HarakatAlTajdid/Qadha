import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/calendar_model.dart';

final calendarServiceProvider = Provider((ref) => CalendarService());

class CalendarService {
  Future<List<CalendarModel>> loadCalendars() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDataRef =
        FirebaseFirestore.instance.collection("userdata").doc(uid);
    final calendarsSnapshot = await userDataRef.collection("calendars").get();

    var calendars = <CalendarModel>[];
    for (final doc in calendarsSnapshot.docs) {
      calendars.add(CalendarModel.fromJson(doc.data(), doc.id));
    }

    return calendars;
  }

  // This method returns the newly created document's id
  Future<String> addCalendar(CalendarModel calendar) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDataRef =
        FirebaseFirestore.instance.collection('userdata').doc(uid);

    final docRef =
        await userDataRef.collection("calendars").add(calendar.toJson());

    // Accordingly increment remaining prayers
    final statsDocRef = userDataRef.collection("stats");
    final statsSnapshot = await statsDocRef.get();

    for (final prayer in statsSnapshot.docs) {
      final data = prayer.data();

      int remaining = 0;
      if (data.containsKey("remaining")) {
        remaining = data["remaining"] as int;
      }

      await statsDocRef.doc(prayer.id).set(
          {"remaining": remaining + calendar.totalDays()},
          SetOptions(merge: true));
    }

    return docRef.id;
  }

  Future<bool> deleteCalendar(CalendarModel calendar) async {
    if (calendar.id == null) {
      throw Exception("Calendar should have a non-null id");
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("userdata")
        .doc(uid)
        .collection("calendars")
        .doc(calendar.id)
        .delete();

    // Accordingly decrement remaining prayers
    final userDataRef =
        FirebaseFirestore.instance.collection('userdata').doc(uid);
    final statsDocRef = userDataRef.collection("stats");
    final statsSnapshot = await statsDocRef.get();

    for (final prayer in statsSnapshot.docs) {
      final data = prayer.data();

      if (data.containsKey("remaining")) {
        final remaining = data["remaining"] as int;
        await statsDocRef.doc(prayer.id).set({
          "remaining": remaining - calendar.totalDays() < 0
              ? 0
              : remaining - calendar.totalDays()
        }, SetOptions(merge: true));
      }
    }

    return true;
  }
}
