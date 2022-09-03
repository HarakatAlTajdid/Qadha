import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/services/calendars_service.dart';
import 'package:qadha/ui/app/locator.dart';
import 'package:stacked/stacked.dart';

class AddCalendarViewModel extends BaseViewModel {
  final CalendarsService _calendarsService = locator<CalendarsService>();
  final List<CalendarModel> calendars;

  DateTime? start;
  DateTime? end;
  int step = 1; // 1 = start, 2 = end, 3 = done

  bool isWorking = false;
  bool calendarOverlapError = false;

  AddCalendarViewModel(this.calendars);

  void select(DateTime day) {
    if (step == 1) {
      start = day;
      step = 2;
    }
    else if (step == 2) {
      if (day.difference(start!).inDays > 2) {
        end = day;
      } 
      else {
        return;
      }
    }

    notifyListeners();
  }

  Future<void> addCalendar(BuildContext context) async {
    isWorking = true;
    notifyListeners();

    final newCalendar = CalendarModel(start!, end!);
    for (final calendar in calendars) {
      if (newCalendar.intersectsWith(calendar)) {
        calendarOverlapError = true;
        isWorking = false;
        notifyListeners();
        return;
      }
    }

    await _calendarsService.addCalendar(newCalendar);

    // ignore: use_build_context_synchronously
    AutoRouter.of(context).pop();
  }
} 