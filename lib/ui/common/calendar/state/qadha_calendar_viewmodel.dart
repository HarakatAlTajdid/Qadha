import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'qadha_calendar_state.dart';

final qadhaCalendarProvider =
    StateNotifierProvider<QadhaCalendarNotifier, QadhaCalendarState>((ref) {
  return QadhaCalendarNotifier();
});

class QadhaCalendarNotifier extends StateNotifier<QadhaCalendarState> {
  QadhaCalendarNotifier() : super(QadhaCalendarState.initial()) {
    _retrieveCurrentFrame();
  }

  String prettyCurrentFrame() {
    return DateFormat("MMMM yyyy", "fr_fr").format(state.currentFrame);
  }

  void setFrame(int increment) {
    state = state.copyWith(currentFrame: DateTime(state.currentFrame.year, state.currentFrame.month + increment));
    _retrieveCurrentFrame();
  }

  // Retrieves a list of 42 days to be displayed for current frame
  void _retrieveCurrentFrame() {
    state = state.copyWith(days: List.from(state.days)..clear());

    final currentFrameDaysCount =
        DateTime(state.currentFrame.year, state.currentFrame.month + 1, 0).day;
    final currentFrameFirstDay =
        DateTime.utc(state.currentFrame.year, state.currentFrame.month, 1).weekday;

    // First day is not Monday, generate the preceeding days from
    // the preceeding frame, like a visual padding
    if (currentFrameFirstDay != 1) {
      for (int i = 1; i < currentFrameFirstDay; i++) {
        final day =
            state.currentFrame.subtract(Duration(days: currentFrameFirstDay - i));
        state = state.copyWith(days: List.from(state.days)..add(day));
      }
    }

    for (int i = 1; i <= currentFrameDaysCount; i++) {
      final day = DateTime(state.currentFrame.year, state.currentFrame.month, i);
      state = state.copyWith(days: List.from(state.days)..add(day));
    }

    if (state.days.length < 42) {
      final missingDaysCount = 42 - state.days.length;
      for (int i = 0; i < missingDaysCount; i++) {
        final day =
            DateTime(state.days.last.year, state.days.last.month, state.days.last.day + 1);
        state = state.copyWith(days: List.from(state.days)..add(day));
      }
    }
  }
}
