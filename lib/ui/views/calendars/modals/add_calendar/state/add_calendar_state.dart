class AddCalendarState {
  final DateTime? start;
  final DateTime? end;
  final int step; // 1 = start, 2 = end, 3 = done
  final bool isWorking;
  final bool calendarOverlapError;

  AddCalendarState(
      {required this.start,
      required this.end,
      required this.step,
      required this.isWorking,
      required this.calendarOverlapError});

  factory AddCalendarState.initial() {
    return AddCalendarState(
        start: null,
        end: null,
        step: 1,
        isWorking: false,
        calendarOverlapError: false);
  }

  AddCalendarState copyWith(
      {DateTime? start,
      DateTime? end,
      int? step,
      bool? isWorking,
      bool? calendarOverlapError}) {
    return AddCalendarState(
        start: start ?? this.start,
        end: end ?? this.end,
        step: step ?? this.step,
        isWorking: isWorking ?? this.isWorking,
        calendarOverlapError:
            calendarOverlapError ?? this.calendarOverlapError);
  }
}
