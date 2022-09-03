import 'package:flutter/material.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/services/calendars_service.dart';
import 'package:qadha/ui/app/locator.dart';

class CalendarProvider with ChangeNotifier {
  final CalendarsService _service = locator<CalendarsService>();
  
  List<CalendarModel> _calendars = [];
  List<CalendarModel> get calendars => _calendars;

  CalendarProvider() {
    _loadCalendars();
  }

  void _loadCalendars() async {
    _calendars = await _service.loadCalendars();
    notifyListeners();
  }

  Future<void> addCalendar(CalendarModel calendar) async {
    final id = await _service.addCalendar(calendar);
    _calendars.add(CalendarModel(calendar.start, calendar.end, id: id));
    notifyListeners();
  }

  void deleteCalendar(CalendarModel calendar) {
    _service.deleteCalendar(calendar);

    for (int i = 0; i < _calendars.length; i++) {
      if (_calendars[i].id == calendar.id) {
        _calendars.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }
} 