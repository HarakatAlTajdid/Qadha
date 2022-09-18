import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/services/stats_service.dart';

final remainingPrayersProvider =
    StateNotifierProvider<RemainingPrayersNotifier, List<int>>((ref) {
  return RemainingPrayersNotifier(ref);
});


class RemainingPrayersNotifier extends StateNotifier<List<int>> {
  final StateNotifierProviderRef<RemainingPrayersNotifier, List<int>> _ref;

  RemainingPrayersNotifier(this._ref) : super([0, 0, 0, 0, 0]) {
    _loadData();
  }

  void _loadData() async {
    state = [
      await _getRemainingPrayers("fajr"),
      await _getRemainingPrayers("dhor"),
      await _getRemainingPrayers("asr"),
      await _getRemainingPrayers("maghreb"),
      await _getRemainingPrayers("icha"),
    ];
  }

    Future<int> _getRemainingPrayers(String type) async {
    return await _ref.read(statsServiceProvider).getRemainingPrayers(type);
  }

  void increment(String type, int increment) async {
    final types = ["fajr", "dhor", "asr", "maghreb", "icha"];
   
    var modifiedState = List.from(state);
    modifiedState[types.indexOf(type)] -= increment;
    state = modifiedState.cast<int>();
  }

  void incrementWithCalendar(int days, {bool add = true}) {
    var modifiedState = List.from(state);
    for (int i = 0; i < 5; i++) {
      modifiedState[i] += add ? days : -days;
      if (modifiedState[i] < 0) modifiedState[i] = 0;
    }
    
    state = modifiedState.cast<int>();
  }
}