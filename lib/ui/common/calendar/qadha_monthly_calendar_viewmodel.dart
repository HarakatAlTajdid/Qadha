import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class QadhaMonthlyCalendarViewModel extends BaseViewModel {
  late DateTime currentFrame;
  List<DateTime> days = []; // 42 days needed

  final DateTime? selectionStart;
  final DateTime? selectionEnd;

  QadhaMonthlyCalendarViewModel(this.selectionStart, this.selectionEnd) {
    if (selectionStart == null) {
      currentFrame = DateTime(DateTime.now().year, DateTime.now().month);
    } else {
      currentFrame = DateTime(selectionStart!.year, selectionStart!.month);
    }
    
    getDaysForCurrentFrame();
  }

  String prettyCurrentFrame() {
    return DateFormat("MMMM yyyy", "fr_fr").format(currentFrame);
  }

  void setFrame(int increment) {
    currentFrame = DateTime(currentFrame.year, currentFrame.month + increment);
    getDaysForCurrentFrame();
  }

  // Retrieves a list of 42 days to be displayed for current frame
  void getDaysForCurrentFrame() {
    days.clear();

    final currentFrameDaysCount =
        DateTime(currentFrame.year, currentFrame.month + 1, 0).day;
    final currentFrameFirstDay =
        DateTime.utc(currentFrame.year, currentFrame.month, 1).weekday;

    // First day is not Monday, generate the preceeding days from
    // the preceeding frame, as a visual padding
    if (currentFrameFirstDay != 1) {
      for (int i = 1; i < currentFrameFirstDay; i++) {
        final day =
            currentFrame.subtract(Duration(days: currentFrameFirstDay - i));
        days.add(day);
      }
    }

    for (int i = 1; i <= currentFrameDaysCount; i++) {
      final day = DateTime(currentFrame.year, currentFrame.month, i);
      days.add(day);
    }

    if (days.length < 42) {
      final missingDaysCount = 42 - days.length;
      for (int i = 0; i < missingDaysCount; i++) {
        final day =
            DateTime(days.last.year, days.last.month, days.last.day + 1);
        days.add(day);
      }
    }

    notifyListeners();
  }
}
