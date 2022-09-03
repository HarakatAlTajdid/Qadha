import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/services/calendars_service.dart';
import 'package:qadha/ui/app/locator.dart';
import 'package:stacked/stacked.dart';

class CalendarsViewModel extends BaseViewModel {
  final CalendarsService calendarsService = locator<CalendarsService>();

  late List<CalendarModel> calendars;
  bool isWorking = true;

  Future<void> loadCalendars() async {
    calendars = await calendarsService.loadCalendars();

    isWorking = false;
    notifyListeners();
  }

  void deleteCalendar(CalendarModel calendar) async {
    await calendarsService.deleteCalendar(calendar);
    await loadCalendars();
  }
}