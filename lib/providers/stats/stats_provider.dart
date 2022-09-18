import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/models/prayer_activity_model.dart';
import 'package:qadha/providers/remaining_prayers_provider.dart';
import 'package:qadha/providers/stats/stats_state.dart';
import 'package:qadha/services/stats_service.dart';

final statsProvider = StateNotifierProvider<StatsNotifier, StatsState>((ref) {
  return StatsNotifier(ref);
});

class StatsNotifier extends StateNotifier<StatsState> {
  final StateNotifierProviderRef<StatsNotifier, StatsState> _ref;

  StatsNotifier(this._ref) : super(StatsState.initial()) {
    loadStats();
  }

  void loadStats() async {
    final activities = await _ref.read(statsServiceProvider).loadActivities();
    state = state.copyWith(activities: activities);
  }

  int getDonePrayers({String? type, int? year, int? month, int? day}) {
    int sum = 0;
    for (final activity in state.activities) {
      bool keep = false;

      if (type != null) {
        keep = activity.type == type;
      }

      if (year != null) {
        keep = activity.date.year == year;
      }

      if (month != null) {
        keep = activity.date.month == month;
      }

      if (day != null) {
        keep = activity.date.day == day;
      }

      if (keep) {
        sum += activity.count;
      }
    }

    return sum;
  }

  void incrementDailyPrayer(String type, int increment) {
    _ref
        .read(statsServiceProvider)
        .incrementActivity(type, DateTime.now(), increment);
    _ref.read(remainingPrayersProvider.notifier).increment(type, increment);
    state = state.copyWith(
        activities: List.from(state.activities)
          ..add(PrayerActivityModel(type, DateTime.now(), increment)));
  }

  List<FlSpot> generateMonthlyStats(List<PrayerActivityModel> activities) {
    var spots = <FlSpot>[];
    for (int i = 30; i > 0; i--) {
      final date = DateTime.now().subtract(Duration(days: 30 - i));
      final value =
          getDonePrayers(year: date.year, month: date.month, day: date.day);
      final spot = FlSpot(i.toDouble(), value.toDouble());
      spots.add(spot);
    }

    return spots.reversed.toList();
  }

  List<FlSpot> generateYearlyStats(List<PrayerActivityModel> activities) {
    var spots = <FlSpot>[];
    for (int i = 7; i > 0; i--) {
      final date = DateTime(DateTime.now().year, DateTime.now().month - 7 + i);
      final value = getDonePrayers(year: date.year, month: date.month);
      final spot = FlSpot(i.toDouble(), value.toDouble());
      spots.add(spot);
    }

    return spots.reversed.toList();
  }

  // 0: progress percentage
  // 1: total remaining rakat
  List<int> getGeneralProgress(List<int> remainingPrayers, List<CalendarModel> calendars) {
    int totalRemaining = 0;
    for (final remaining in remainingPrayers) {
      totalRemaining += remaining;
    }

    int totalRakaa = 0;
    for (final calendar in calendars) {
      totalRakaa += calendar.totalDays() * 5;
    }

    double quotient = (totalRakaa - totalRemaining) / totalRakaa;
    if (totalRakaa == 0) {
      return [-1, 0];
    } else if (quotient > 1) {
      return [100, 0];
    }

    return [
      (quotient * 100).toInt(),
      totalRemaining
    ];
  }

  // 0: progress percentage
  // 1: total remaining rakat
  double getSpecificProgress(String prayer, int remaining, List<CalendarModel> calendars) {
    int totalRakaa = 0;
    for (final calendar in calendars) {
      totalRakaa += calendar.totalDays();
    }

    double quotient = (totalRakaa - remaining) / totalRakaa;
    if (totalRakaa == 0) {
      return -1;
    } else if (quotient > 1) {
      return 1;
    }

    if (quotient < 0) {
      return 0;
    }

    return quotient;
  }
}
