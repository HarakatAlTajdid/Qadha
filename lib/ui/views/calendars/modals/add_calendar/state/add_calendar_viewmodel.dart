import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/providers/calendar_provider.dart';
import 'package:qadha/ui/views/calendars/modals/add_calendar/state/add_calendar_state.dart';

final addCalendarProvider =
    StateNotifierProvider<AddCalendarNotifier, AddCalendarState>((ref) {
  return AddCalendarNotifier(ref);
});

class AddCalendarNotifier extends StateNotifier<AddCalendarState> {
  final StateNotifierProviderRef<AddCalendarNotifier, AddCalendarState> _ref;

  AddCalendarNotifier(this._ref) : super(AddCalendarState.initial());

  void select(DateTime day) {
    if (state.step == 1) {
      state = state.copyWith(start: day);
      state = state.copyWith(step: 2);
    } else if (state.step == 2) {
      if (day.difference(state.start!).inDays > 2) {
        state = state.copyWith(end: day);
      }
    }
  }

  bool reset() {
    state = AddCalendarState.initial();
    return true;
  }

  Future<bool> addCalendar() async {
    state = state.copyWith(isWorking: true);

    final newCalendar = CalendarModel(state.start!, state.end!);
    for (final calendar in _ref.watch(calendarProvider)) {
      if (newCalendar.intersectsWith(calendar)) {
        state = state.copyWith(calendarOverlapError: true);
        state = state.copyWith(isWorking: false);
        return false;
      }
    }

    await _ref.read(calendarProvider.notifier).addCalendar(newCalendar);

    return true;
  }
}
