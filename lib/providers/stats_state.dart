import '../models/prayer_activity_model.dart';

class StatsState {
  final List<PrayerActivityModel> activities;

  StatsState({required this.activities});

  factory StatsState.initial() {
    return StatsState(activities: []);
  }

  StatsState copyWith(
      {List<PrayerActivityModel>? activities}) {
    return StatsState(
        activities: activities ?? this.activities);
  }
}
