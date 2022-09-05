import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/services/calendars_service.dart';

final calendarProvider =
    StateNotifierProvider<CalendarNotifier, List<CalendarModel>>((ref) {
  return CalendarNotifier(ref.read(calendarServiceProvider));
});

class CalendarNotifier extends StateNotifier<List<CalendarModel>> {
  final CalendarService _calendarService;

  CalendarNotifier(this._calendarService) : super([]) {
    _loadCalendars();
  }

  void _loadCalendars() async {
    state = await _calendarService.loadCalendars();
  }

  Future<void> addCalendar(CalendarModel calendar) async {
    final id = await _calendarService.addCalendar(calendar);
    state = List.from(state)..add(CalendarModel(calendar.start, calendar.end, id: id));
  }

  void deleteCalendar(CalendarModel calendar) {
    _calendarService.deleteCalendar(calendar);
    state = List.from(state)..removeWhere((element) => element.id == calendar.id);
  }
}