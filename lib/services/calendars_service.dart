import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qadha/models/calendar_model.dart';

class CalendarsService {
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

    final docRef = await userDataRef.collection("calendars").add(calendar.toJson());
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

    return true;
  }
}
