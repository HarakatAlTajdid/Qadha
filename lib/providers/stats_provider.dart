import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/providers/calendar_provider.dart';
import 'package:qadha/providers/stats_state.dart';
import 'package:qadha/services/stats_service.dart';

final statsProvider = StateNotifierProvider<StatsNotifier, StatsState>((ref) {
  return StatsNotifier(ref);
});

class StatsNotifier extends StateNotifier<StatsState> {
  final StateNotifierProviderRef<StatsNotifier, StatsState> _ref;

  StatsNotifier(this._ref) : super(StatsState.initial()) {
    _loadStats();
  }

  void _loadStats() async {
    final activities = await _ref.read(statsServiceProvider).loadActivities();
    state = state.copyWith(activities: activities, remainingPrayers: [
      _getRemainingPrayers("fajr"),
      _getRemainingPrayers("dhor"),
      _getRemainingPrayers("asr"),
      _getRemainingPrayers("maghreb"),
      _getRemainingPrayers("icha"),
    ]);
  }

  int _getCalendarsDaysSum() {
    final calendars = _ref.watch(calendarProvider);

    var sum = 0;
    for (final calendar in calendars) {
      sum += calendar.end.difference(calendar.start).inDays;
    }

    return sum;
  }

  int getDonePrayers({String? type, DateTime? date}) {
    var sum = 0;
    for (final activity in state.activities) {
      bool keep = false;

      if (type != null) {
        keep = activity.type == type;
      }

      if (date != null) {
        keep = activity.date == date;
      }

      if (keep) {
        sum++;
      }
    }

    return sum;
  }

  int _getRemainingPrayers(String type) {
    return _getCalendarsDaysSum() + 1 - getDonePrayers(type: type);
  }

  void incrementDailyPrayer(String prayer, int increment) {
  }
}
