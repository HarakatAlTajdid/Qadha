import '../models/prayer_activity_model.dart';

class StatsState {
  final List<PrayerActivityModel> activities;
  final List<int> remainingPrayers;

  StatsState({required this.activities, required this.remainingPrayers});

  factory StatsState.initial() {
    return StatsState(activities: [], remainingPrayers: [0, 0, 0, 0, 0]);
  }

  StatsState copyWith(
      {List<PrayerActivityModel>? activities, List<int>? remainingPrayers}) {
    return StatsState(
        activities: activities ?? this.activities,
        remainingPrayers: remainingPrayers ?? this.remainingPrayers);
  }
}
